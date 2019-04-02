%% Copyright 2019, Travelping GmbH <info@travelping.com>
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Lesser General Public License as
%% published by the Free Software Foundation, either version 3 of the
%% License, or (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
%% GNU Lesser General Public License for more details.
%%
%% You should have received a copy of the GNU Lesser General Public License
%% along with this program. If not, see <http://www.gnu.org/licenses/>.

%%% -------------------------------------------------------
%%% ENUM Macros:
%%% -------------------------------------------------------

-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_NORMAL_RELEASE', 0).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_ABNORMAL_RELEASE', 1).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_QOS_CHANGE', 2).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_VOLUME_LIMIT', 3).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_TIME_LIMIT', 4).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVING_NODE_CHANGE', 5).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVING_NODE_PLMN_CHANGE', 6).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_USER_LOCATION_CHANGE', 7).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_RAT_CHANGE', 8).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_UE_TIMEZONE_CHANGE', 9).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_TARIFF_TIME_CHANGE', 10).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVICE_IDLED_OUT', 11).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVICESPECIFICUNITLIMIT', 12).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_MAX_NUMBER_OF_CHANGES_IN_CHARGING_CONDITIONS', 13).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_CGI_SAI_CHANGE', 14).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_RAI_CHANGE', 15).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_ECGI_CHANGE', 16).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_TAI_CHANGE', 17).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVICE_DATA_VOLUME_LIMIT', 18).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVICE_DATA_TIME_LIMIT', 19).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_MANAGEMENT_INTERVENTION', 20).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVICE_STOP', 21).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_USER_CSG_INFORMATION_CHANGE', 22).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SGW_CHANGE', 23).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_CHANGE_OF_UE_PRESENCE_IN_PRESENCE_REPORTING_AREA', 24).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_PROXIMITY_ALERTED', 25).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_TIME_EXPIRED_WITH_NO_RENEWAL', 26).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_REQUESTOR_CANCELLATION', 27).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_MAXIMUM_NUMBER_OF_REPORTS', 28).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_PLMN_CHANGE', 29).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_COVERAGE_STATUS_CHANGE', 30).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_REMOVAL_OF_ACCESS', 31).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_UNAVAILABILITY_OF_ACCESS', 32).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_ACCESS_CHANGE_OF_SERVICE_DATA_FLOW', 33).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_INDIRECT_CHANGE_CONDITION', 34).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_MAXIMUM_NUMBER_OF_NIDD_SUBMISSIONS', 35).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_CHANGE_IN_UP_TO_UE', 36).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_SERVING_PLMN_RATE_CONTROL_CHANGE', 37).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_APN_RATE_CONTROL_CHANGE', 38).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_NIDD_SUBMISSION_RESPONSE_RECEIPT', 39).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_NIDD_SUBMISSION_RESPONSE_SENDING', 40).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_NIDD_DELIVERY_TO_UE', 41).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_NIDD_DELIVERY_FROM_UE_ERROR', 42).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_NIDD_SUBMISSION_TIMEOUT', 43).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_MO_EXCEPTION_DATA_COUNTER', 44).
-define('DIAMETER_3GPP_CHARGING-CHANGE-CONDITION_CHANGE_OF_3GPP_PS_DATA_OFF_STATUS', 45).