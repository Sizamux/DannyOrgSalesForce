public with sharing class AccountUtility {
    
    public static void viewAnnualRevenue(){
        // Create a query and assign the results to a list
        List<Account> accountsList =new List<Account>();
        // Fields: Account Name and Annual Revenue (Hint: Use API names, not field names or labels)
        // Object: Account
        accountsList = [SELECt Name, AnnualRevenue FROM Account];
        // Create a for loop that iterates through the query results
        // Object: Account
        // List name: accountsList
        for (Account item : accountsList) {
            // For each item, concatenate the account name, followed by a colon, followed by the account’s annual revenue: <Account Name> : <Annual Revenue>
            // Store the concatenated string in a variable named acctRev
            String acctRev = item.Name + ' : ' + item.AnnualRevenue;
            // Print the acctRev variable to the debug log
            system.debug(acctRev);    
        }
    }
}