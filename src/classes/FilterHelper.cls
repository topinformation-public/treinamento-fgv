public class FilterHelper {

    public static Set<String> filterFieldIds ( String field, List<SObject> records ) {

        Set<String> filtered = new Set<String>();
        for ( SObject record : records  ) {
            if ( record.get(field) != null) {
                filtered.add ( (String) record.get(field) );
            }
        }
        
        return filtered;
    }


}