import Company from "@salesforce/schema/Lead.Company";

const build = (enrollment) => {

    return { lead : {
            LastName : enrollment.name
            , Company : '-'
            , Phone : enrollment.phone
            , DocumentNumber__c : enrollment.documentNumber
            , Email : enrollment.email
            }
    };
}

export {build}