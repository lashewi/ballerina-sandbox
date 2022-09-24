import ballerina/graphql;
import ballerina/http;

http:Client httpClient = check new("http://localhost:9091/");

// Don't change the port number
service /graphql on new graphql:Listener(9090) {

    // Write your answer here. You must change the input and
    // the output of the below signature along with the logic.
    resource function get sleepSummary(string ID, TimeUnit timeunit) returns SleepSummary[]|error {
        json sleeDataResponse = check getUserSleepData(ID);
        return sleepDataResolver(sleeDataResponse, timeunit);
    }
}

function getUserSleepData(string userId) returns json|error {
    string query = string`activities/summary/sleep/user/${userId}`;
    return httpClient->get(query);
}

function sleepDataResolver(json data, TimeUnit timeunit) returns SleepSummary[]|error {
    SleepSummary[] response = [];

    json sleepJson = check data.sleep;
    Sleep[] sleepRecords = check sleepJson.cloneWithType();

    foreach Sleep value in sleepRecords {

        int deep = value.levels.summary.deep.minutes;
        int wake = value.levels.summary.wake.minutes;
        int light = value.levels.summary.light.minutes;

        int duration = value.duration;

        if(timeunit == SECONDS){
            deep = deep * 60;
            wake = wake * 60;
            light = light * 60;
            duration = duration * 60;
        } 

        Levels levels = {
            deep: deep,
            wake: wake,
            light: light
        };

        SleepSummary summary = {
            date: value.date,
            duration: duration,
            levels: levels
        };

        response.push(summary);
    }

    return response;
}