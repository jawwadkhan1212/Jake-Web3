public with sharing class Web3EnablerSetup {
    public String orgId { get; set; }
    public AuthorizationStatus authorizationStatus { get; set; }
    
    public Web3EnablerSetup() {
        orgId = UserInfo.getOrganizationId();
        getAuthorizationStatus();
    }
    
public void getAuthorizationStatus() {
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://muknweb3ca.herokuapp.com/organization/' + orgId);
    req.setMethod('GET');
    Http http = new Http();
    HttpResponse res = http.send(req);
    if (res.getStatusCode() == 200) {
        authorizationStatus = (AuthorizationStatus)JSON.deserialize(res.getBody(), AuthorizationStatus.class);
    } else {
        authorizationStatus = new AuthorizationStatus();
        authorizationStatus.organization_uuid = '';
                authorizationStatus.orgid = '';
        authorizationStatus.org_url = '';
        authorizationStatus.authorized = false;
    }
}
    
    public class AuthorizationStatus {
        public String organization_uuid { get; set; }
        public String orgid { get; set; }
        public String org_url { get; set; }
        public Boolean authorized { get; set; }
    }
    
    public PageReference authorize() {
        String url = 'https://muknweb3ca-sfdc.herokuapp.com/install?orgId=' + orgId;
        return new PageReference(url);
    }

    public PageReference reauthorize() {
        String url = 'https://muknweb3ca-sfdc.herokuapp.com/reauthorize?orgId=' + orgId;
        return new PageReference(url);
    }

}