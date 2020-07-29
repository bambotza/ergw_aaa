DIAMETER AVP Filter
===================

Diameter is a very flexible protocol allowing vendor/service specific customisations of AVPs compared to standards. Also the AVPs may change with different versions of the standards. This results in the requirement of some level of customisation of the AVPs the ERGW uses to communicate with external systems implementing different versions of the standards or vendor/service specific quirks.

This implementation uses the approach of including all extra AVPs that can possibly be used, and with a configurable filter deletes the ones we don't want to use in a deployment on a specific interface.

The filtering functionality is implemented for all AAA diameter handlers (Ro/Gy - `ergw_aaa_ro`, Rf - `ergw_aaa_rf`, Gx - `ergw_aaa_gx`, NASREQ - `ergw_aaa_nasreq`) and can be configured for these.


Extra AVPs 
----------
The following AVPs are generated by different handlers in a non-standard way to facilitate specific implementations

| handler           | extra AVP            | Comment                                                              |
|-------------------|----------------------|----------------------------------------------------------------------|
| `ergw_aaa_ro`     | `'3GPP-IMSI'`        | Standard AVP but the use in the CCR root is not according to spec    |
| `ergw_aaa_nasreq` | `'Framed-Pool'`      | Standard AVP in responses but the use in request (AAR) is not        |
| `ergw_aaa_nasreq` | `'Framed-IPv6-Pool'` | Standard AVP in responses but the use in request (AAR) is not        |

These AVP's are filtered out by default if no other filter is defined in the handler/procedure. If any custom filter is specified in the handler configuration or procedure configuration (overriding the handler configuration), it will replace the default filter. I.e. filtering the AVPs above, should be added to the configuration if they are not to be included in the messages.


Filter
------
The filter is a list of paths in the nested diameter AVP structure pointing to AVPs to delete. If a path specified in the filter list is found in the diameter message emitted from the application, then it will be deleted.

e.g. `[Path1, Path2, Path3]` filter will delete 3 AVPs pointed to by each Path if they are present in the message. 


Path
----
A path can contain `branches` and `conditions`. Each branch (AVP name) will go one level deeper in the AVP structure and each condition (list of AVP name and value matches) will check if traversing the path should continue based on specific AVP values on the current level.

e.g. in this structure 
```
    #{avp1 => [
        #{avp2 => 1
          avp3 => 2},
        #{avp2 => 2,
          avp3 => 3}
    ]}
```

`[avp1, [{avp2, 1}], avp3]` will delete avp3 in the first instance since that is matchin the condition resulting in

```
    #{avp1 => [
        #{avp2 => 1},
        #{avp2 => 2,
          avp3 => 3}
    ]}
```

If a `condition` is the last element in the path then it will delete any matching structure on the current level. Using filter `[avp1, [{avp2, 1}]]` will result in completely removing the 1st instance of structures under avp1

```
    #{avp1 => [
        #{avp2 => 2,
          avp3 => 3}
    ]}
```

If there is no `condition` in the path then the filter will remove the APV defined in the last `branch`. Using filter `[avp1, avp2]` will result in removing avp2 from all the instances.
```
    #{avp1 => [
        #{avp3 => 2},
        #{avp3 => 3}
    ]}
``` 


It is also possible to use conditions on the top level, conditioning the deletion of any AVP based on top level AVP values. It should obviously not be used as a single element in the path, as it would delete all AVPs in the message. To prevent this, the application ignores single element path where the element is a condition.

NOTE: Of course removing an AVP marked as positional/mandatory in the dictionary definion will result in encoding failure. I.e. we are not referring to the M bit in the AVP definition, but APVs marked `<avp>` or `{avp}` in the ABNF definition of the messages. 


Configuration
-------------

The AVP filter can be configured in the `handlers` section of the `ergw_aaa` application e.g.

```
[
    ...
    {ergw_aaa, [
        ...
        {handlers, [
            ...
            {ergw_aaa_ro, [
                ...
                {avp_filter, [
                    ['Subscription-Id', [{'Subscription-Id-Type', 1}]]
                ]}
                ...
            ]}
            ...
        ]}
        ...
    ]}
    ...
]
```

Practical example
-----------------

Initial structure from the `ergw_aaa_ro` handler (note the presence of the `'3GPP-IMSI'` extra AVP)

```
#{
    '3GPP-IMSI' => [<<"250071234567890">>],
    'Auth-Application-Id' => 4,
    'CC-Request-Number' => 0,
    'CC-Request-Type' => 1,
    'Destination-Realm' => <<"test-srv.example.com">>,
    'Event-Timestamp' => [{{2020,5,2},{17,12,45}}],
    'Multiple-Services-Credit-Control' => [
        #{
            'Rating-Group' => [1000],
            'Requested-Service-Unit' => #{}
        }
    ],
    'Multiple-Services-Indicator' => [1],
    'Origin-Host' => <<"127.0.0.1">>,
    'Origin-Realm' => <<"example.com">>,
    'Origin-State-Id' => [1649944708],
    'Service-Context-Id' => "14.32251@3gpp.org",
    'Service-Information' => [
        #{
            'PS-Information' => [
                #{
                    '3GPP-Charging-Characteristics' => [<<"0800">>],
                    '3GPP-Charging-Id' => [3604013806],
                    '3GPP-GGSN-MCC-MNC' => [<<"25888">>],
                    '3GPP-IMSI-MCC-MNC' => [<<"25999">>],
                    '3GPP-MS-TimeZone' => [<<128,1>>],
                    '3GPP-NSAPI' => [<<"5">>],
                    '3GPP-PDP-Type' => [0],
                    '3GPP-RAT-Type' => [<<6>>],
                    '3GPP-SGSN-MCC-MNC' => [<<"26201">>],
                    '3GPP-Selection-Mode' => [<<"0">>],
                    '3GPP-User-Location-Info' =>
                        [<<24,98,242,16,64,163,98,242,16,1,156,232,0>>],
                    'Called-Station-Id' => [<<"some.station.gprs">>],
                    'Charging-Characteristics-Selection-Mode' => [3],
                    'Charging-Rule-Base-Name' => [<<"m2m0001">>],
                    'GGSN-Address' => [{172,20,16,28}],
                    'Node-Id' => [<<"PGW-001">>],
                    'PDN-Connection-Charging-ID' => [3604013806],
                    'PDP-Address' => [{10,106,14,227}],
                    'PDP-Context-Type' => [0],
                    'SGSN-Address' => [{192,168,1,1}]
                }
            ]
        }
    ],
    'Session-Id' => <<"lt;536965590;1612833792;913179202621">>,
    'Subscription-Id' => [
        #{
            'Subscription-Id-Data' => <<"46702123456">>,
            'Subscription-Id-Type' => 0
        },
       #{
            'Subscription-Id-Data' => <<"250071234567890">>,
            'Subscription-Id-Type' => 1
        }
    ],
    'User-Equipment-Info' => [
        #{
            'User-Equipment-Info-Type' => 0,
            'User-Equipment-Info-Value' => <<82,21,50,96,32,80,30,0>>
        }
    ],
    'User-Name' => [<<"ergw">>]
}
```

e.g. a filter to remove the IMSI from the 'Subscription-Id' (using a condition of 'Subscription-Id-Type' = 1) AVP:

```
[
    ['Subscription-Id', [{'Subscription-Id-Type', 1}]]
]
```

will result in the structure

```
#{
    '3GPP-IMSI' => [<<"250071234567890">>],
    'Auth-Application-Id' => 4,
    'CC-Request-Number' => 0,
    'CC-Request-Type' => 1,
    'Destination-Realm' => <<"test-srv.example.com">>,
    'Event-Timestamp' => [{{2020,5,2},{17,12,45}}],
    'Multiple-Services-Credit-Control' => [
        #{
            'Rating-Group' => [1000],
            'Requested-Service-Unit' => #{}
        }
    ],
    'Multiple-Services-Indicator' => [1],
    'Origin-Host' => <<"127.0.0.1">>,
    'Origin-Realm' => <<"example.com">>,
    'Origin-State-Id' => [1649944708],
    'Service-Context-Id' => "14.32251@3gpp.org",
    'Service-Information' => [
        #{
            'PS-Information' => [
                #{
                    '3GPP-Charging-Characteristics' => [<<"0800">>],
                    '3GPP-Charging-Id' => [3604013806],
                    '3GPP-GGSN-MCC-MNC' => [<<"25888">>],
                    '3GPP-IMSI-MCC-MNC' => [<<"25999">>],
                    '3GPP-MS-TimeZone' => [<<128,1>>],
                    '3GPP-NSAPI' => [<<"5">>],
                    '3GPP-PDP-Type' => [0],
                    '3GPP-RAT-Type' => [<<6>>],
                    '3GPP-SGSN-MCC-MNC' => [<<"26201">>],
                    '3GPP-Selection-Mode' => [<<"0">>],
                    '3GPP-User-Location-Info' =>
                        [<<24,98,242,16,64,163,98,242,16,1,156,232,0>>],
                    'Called-Station-Id' => [<<"some.station.gprs">>],
                    'Charging-Characteristics-Selection-Mode' => [3],
                    'Charging-Rule-Base-Name' => [<<"m2m0001">>],
                    'GGSN-Address' => [{172,20,16,28}],
                    'Node-Id' => [<<"PGW-001">>],
                    'PDN-Connection-Charging-ID' => [3604013806],
                    'PDP-Address' => [{10,106,14,227}],
                    'PDP-Context-Type' => [0],
                    'SGSN-Address' => [{192,168,1,1}]
                }
            ]
        }
    ],
    'Session-Id' => <<"lt;536965590;1612833792;913179202621">>,
    'Subscription-Id' => [
        #{
            'Subscription-Id-Data' => <<"46702123456">>,
            'Subscription-Id-Type' => 0
        }
    ],
    'User-Equipment-Info' => [
        #{
            'User-Equipment-Info-Type' => 0,
            'User-Equipment-Info-Value' => <<82,21,50,96,32,80,30,0>>
        }
    ],
    'User-Name' => [<<"ergw">>]
}
```

Implementation
--------------

The filtering operates on the internal AVP structure of the Erlang diameter application (see example above).

It is implemented in the `prepare_request` function of the `ergw_aaa_diameter_srv` module which performs common functions (e.g. rate limiting or retry) for all diameter connections. This function is a callback of the Erlang diameter application (see : http://erlang.org/doc/man/diameter_app.html#Mod:prepare_request-3)

The function receives the merged `handler` and `procedure` configuration where it looks for the `avp_filter`. If there is no configuration present, then it assumes the default filter.

Support for `avp_filter` configuration is implemented in the diameter handler modules : `ergw_aaa_ro`, `ergw_aaa_gx`, `ergw_aaa_rf` and `ergw_aaa_nasreq`
