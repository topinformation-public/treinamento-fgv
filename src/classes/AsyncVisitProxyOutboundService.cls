//Generated by wsdl2apex

public class AsyncVisitProxyOutboundService {
    public class createResponse_elementFuture extends System.WebServiceCalloutFuture {
        public VisitProxyOutboundService.Visit getValue() {
            VisitProxyOutboundService.createResponse_element response = (VisitProxyOutboundService.createResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.result;
        }
    }
    public class AsyncVisitInboundService {
        public String endpoint_x = 'https://na172.salesforce.com/services/Soap/class/VisitInboundService';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        public VisitProxyOutboundService.SessionHeader_element SessionHeader;
        public VisitProxyOutboundService.DebuggingHeader_element DebuggingHeader;
        public VisitProxyOutboundService.AllowFieldTruncationHeader_element AllowFieldTruncationHeader;
        public VisitProxyOutboundService.DebuggingInfo_element DebuggingInfo;
        public VisitProxyOutboundService.CallOptions_element CallOptions;
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/schemas/class/VisitInboundService';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/schemas/class/VisitInboundService';
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=http://soap.sforce.com/schemas/class/VisitInboundService';
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/schemas/class/VisitInboundService';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/schemas/class/VisitInboundService';
        private String[] ns_map_type_info = new String[]{'http://soap.sforce.com/schemas/class/VisitInboundService', 'VisitProxyOutboundService'};
        public AsyncVisitProxyOutboundService.createResponse_elementFuture beginCreate(System.Continuation continuation,VisitProxyOutboundService.Visit visit) {
            VisitProxyOutboundService.create_element request_x = new VisitProxyOutboundService.create_element();
            request_x.visit = visit;
            return (AsyncVisitProxyOutboundService.createResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncVisitProxyOutboundService.createResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/VisitInboundService',
              'create',
              'http://soap.sforce.com/schemas/class/VisitInboundService',
              'createResponse',
              'VisitProxyOutboundService.createResponse_element'}
            );
        }
    }
}