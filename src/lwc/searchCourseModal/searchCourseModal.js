import { LightningElement, track } from 'lwc';
import Timeout from '@salesforce/schema/BackgroundOperation.Timeout';
 
export default class SearchCourseModal extends LightningElement {

    @track courses = [];

    coursesColumns = [
        {type: "button", typeAttributes: {label: 'Selecionar', name: 'select', title: 'Selecionar', disabled: false, value: 'select', iconPosition: 'left'}},
        {label: 'Curso', fieldName: 'name', type: 'text'},
        {label: 'Data Início', fieldName: 'startDate', type: 'date', typeAttributes: { day: "numeric", month: "numeric", year: "numeric"} },
        {label: 'Valor', fieldName: 'amount', type: 'currency', typeAttributes: { currencyCode: 'BRL'}}
    ];

    course;

    selectedSchool;

    connectedCallback () {
    }

    populateCourses () {
        this.courses = [
            {code : "00001", name: "Pós 1" , startDate : "2020-08-15T00:00:00.000", amount : 20313.0 },
            {code : "00002", name: "Pós 2" , startDate : "2020-09-15T00:00:00.000", amount : 30313.0 },
            {code : "00003", name: "Pós 3" , startDate : "2020-10-15T00:00:00.000", amount : 40313.0 },
            {code : "00004", name: "Pós 4" , startDate : "2020-11-15T00:00:00.000", amount : 50313.0 },
            {code : "00005", name: "Pós 5" , startDate : "2020-12-15T00:00:00.000", amount : 60313.0 }
        ];
    }

    handleCourseChange (event) {
        
        this.course = event.target.value;

        this.populateCourses (); 
    }

    handleSchoolChange (event) {
        this.selectedSchool = event.target.value;
    }

    handleSelectedRow (event) {
        
        const row = event.detail.row;
        this.dispatchEvent (
            new CustomEvent ( 'courseselected' , {detail : { course : row}} 
        ));

    }

}