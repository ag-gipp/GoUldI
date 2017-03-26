package org.citeplag.translate.latexml;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @author Vincent Stange
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ServiceResponse {

    @JsonProperty("status_code")
    int statusCode = 0;

    @JsonProperty("status")
    String status;

    String result;

    String log;

    public ServiceResponse() {
        // emtpy constructor
    }

    public ServiceResponse(String result) {
        this.result = result;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }
}
