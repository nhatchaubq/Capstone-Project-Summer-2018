<template>
    <div>
        <!-- <vue-full-calendar class="material-box material-shadow" :events="calendarEvents" locale="en"></vue-full-calendar> -->
        <croud-gantt :events="events"
             :start-period="startPeriod"
             :end-period="endPeriod"
            
             :inifinteScrol="true"  ></croud-gantt>
        <div class="monthTab" style="align-items:center;justify-content:center;display:flex;padding-top:1rem">
          <div class="wrapper-button" style="display: grid; grid-template-columns: auto auto auto">
            <button class="Previous" v-on:click="previousMonth()"><i class="fa fa-angle-left" style="color:gray;"></i> Pre </button>
            <button class="thisMonthButton" v-on:click="thisMonth()"> This Month </button>
            <button class="Next" v-on:click="nextMonth()"> Next <i class="fa fa-angle-right" style="color:gray;"></i></button>
          </div>
        </div>  
    </div>
</template>

<script>
import data from "@/models/work_orders.js";
import VueFullCalendar from "vue-fullcalendar";
import moment from "moment";
import Utils from "@/utils.js";

export default {
  
  components: {
    VueFullCalendar,
  
  },
  created() {
    
    this.startPeriod=moment().startOf('month');
    this.endPeriod= moment().endOf('month');
    this.axios
      .get("http://localhost:3000/api/work_order/")
      .then(response => {
        let data = response.data.WorkOrders;
        this.orders = data;
        for (var i = 0; i < this.orders.length; i++) {
          this.startMonth = moment().startOf('month').valueOf();
          this.endMonth = moment().endOf('month').valueOf();
          var startOffset = 0;
          var duration = 0;
          var CreateDate = moment(this.orders[i].CreateDate).valueOf();
          var StartDate = moment(this.orders[i].StartDate).valueOf();
          var ExpectingCloseDate = moment(this.orders[i].ExpectingCloseDate).valueOf();
          var ExpectingStartDate = moment(this.orders[i].ExpectingStartDate).valueOf();
          var ClosedDate = moment(this.orders[i].ClosedDate).valueOf();

          // set stardate to find offset
          if(ExpectingStartDate >= this.startMonth && StartDate == null){
            let timeDiffOffset = Math.abs(ExpectingStartDate - this.startMonth);
            startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
          }else if(ExpectingStartDate>=this.startMonth && StartDate != null){
            let timeDiffOffset = Math.abs(StartDate - this.startMonth);
            startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
          }
          
          //set closedate to find duration
          if(this.orders[i].ClosedDate != ""){
            // alert(i);
            if( ClosedDate < this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( ClosedDate - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ClosedDate < this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( ClosedDate - StartDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ClosedDate > this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( endMonth - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ClosedDate > this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( endMonth - StartDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
           if(this.orders[i].ClosedDate === "") {
            // alert(this.orders[i].Name)
             if(ExpectingCloseDate < this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( ExpectingCloseDate - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ExpectingCloseDate < this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( ExpectingCloseDate - CreateDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ExpectingCloseDate > this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( this.endMonth - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ExpectingCloseDate > this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( this.endMonth - StartDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
          if(this.orders[i].ClosedDate != null){
            this.orders[i].ClosedDate = moment(this.orders[i].ClosedDate).format("DD-MM-YYYY");
          }
          if((StartDate < this.startMonth && ClosedDate < this.startMonth) || (StartDate > this.endMonth && ClosedDate > this.endMonth))
          {
            // alert(i)
          }else{
            var event = {
              title: this.orders[i].Name,
              offset: startOffset + 1,
              duration: duration,
              status: this.orders[i].WorkOrderStatus,
              userRequest: this.orders[i].RequestUsername,
              startDate: moment(this.orders[i].CreateDate).format("DD-MM-YYYY"),
              dueDate: moment(this.orders[i].DueDate).format("DD-MM-YYYY"),
              team:  this.orders[i].Team.Name,
              closedDate:  this.orders[i].ClosedDate,
              detail: this.orders[i].WorkOrderDetails,
            };
              this.events.push(event);
          }
          
      }
      })
      .catch(error => {
        console.log(error);
      });

  },
  data() {
    return {
      calendarEvents: [],
      orders: [],
      workorderDetail: [],
      events: [],
      startPeriod: "",
      endPeriod: "",
      startMonth: "",
      endMonth: ""
    };
  },
  methods: {
    previousMonth(){
      this.events = [];
      var date = '2018-0'+ moment(this.startPeriod).month() + '-01'
      this.startPeriod = moment(date).startOf('month');
      this.endPeriod = moment(date).endOf('month');
      alert(moment(date).startOf('month'));
      alert(moment(date).endOf('month'))
      this.startMonth = moment(date).startOf('month').valueOf();
      this.endMonth = moment(date).endOf('month').valueOf();
      this.axios
      .get("http://localhost:3000/api/work_order/")
      .then(response => {
        let data = response.data.WorkOrders;
        this.orders = data;
        for (var i = 0; i < this.orders.length; i++) {
          var startOffset = 0;
          var duration = 0;
          var CreateDate = moment(this.orders[i].CreateDate).valueOf();
          var StartDate = moment(this.orders[i].StartDate).valueOf();
          var ExpectingCloseDate = moment(this.orders[i].ExpectingCloseDate).valueOf();
          var ExpectingStartDate = moment(this.orders[i].ExpectingStartDate).valueOf();
          var ClosedDate = moment(this.orders[i].ClosedDate).valueOf();

          // set stardate to find offset
          if(ExpectingStartDate >= this.startMonth && StartDate == null){
            let timeDiffOffset = Math.abs(ExpectingStartDate - this.startMonth);
            startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
          }else if(ExpectingStartDate>=this.startMonth && StartDate != null){
            let timeDiffOffset = Math.abs(StartDate - this.startMonth);
            startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
          }
          
          //set closedate to find duration
          if(this.orders[i].ClosedDate != ""){
            // alert(i);
            if( ClosedDate < this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( ClosedDate - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ClosedDate < this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( ClosedDate - StartDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ClosedDate > this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( this.endMonth - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ClosedDate > this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( this.endMonth - StartDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
           if(this.orders[i].ClosedDate == "") {
            alert(this.orders[i].Name)
             if(ExpectingCloseDate < this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( ExpectingCloseDate - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ExpectingCloseDate < this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( ExpectingCloseDate - CreateDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ExpectingCloseDate > this.endMonth && StartDate < this.startMonth){
              var timeDiffDuration = Math.abs( this.endMonth - this.startMonth)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }else if(ExpectingCloseDate > this.endMonth && StartDate > this.startMonth){
              var timeDiffDuration = Math.abs( this.endMonth - StartDate)
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
          if(this.orders[i].ClosedDate != null){
            this.orders[i].ClosedDate = moment(this.orders[i].ClosedDate).format("DD-MM-YYYY");
          }
          
          if((StartDate < this.startMonth && ClosedDate < this.startMonth) || (StartDate > this.endMonth && ClosedDate > this.endMonth))
          {
            // alert(i)
          }else{
            var event = {
              title: this.orders[i].Name,
              offset: startOffset + 1,
              duration: duration,
              status: this.orders[i].WorkOrderStatus,
              userRequest: this.orders[i].RequestUsername,
              startDate: moment(this.orders[i].CreateDate).format("DD-MM-YYYY"),
              dueDate: moment(this.orders[i].DueDate).format("DD-MM-YYYY"),
              team:  this.orders[i].Team.Name,
              closedDate:  this.orders[i].ClosedDate,
              detail: this.orders[i].WorkOrderDetails,
            };
              this.events.push(event);
          }
      }
      })
      .catch(error => {
        console.log(error);
      });
    },
    nextMonth(){
      var nextMonth = moment(this.startPeriod).month() + 2
      var date = '2018-0'+ nextMonth + '-01'
      this.startPeriod = moment(date).startOf('month');
      this.endPeriod = moment(date).endOf('month');
      this.startMonth = moment(date).startOf('month').valueOf();
      this.endMonth = moment(date).endOf('month').valueOf();
    },
    thisMonth(){
      this.startPeriod = moment().startOf('month');
      this.endPeriod = moment().endOf('month');
      this.startMonth = moment().startOf('month').valueOf();
      this.endMonth = moment().endOf('month').valueOf();
      location.reload();
    }
  },
  watch:{
    addPopUp: function() {
      if (this.addPopUp == false) {
        
      }
  
    }
  }
  
};
</script>

<style scoped>
.Previous{
  /* border-top-left-radius:8px;
  border-bottom-left-radius:8px; */
  /* border-left: 1px #9e9e9e solid;
  border-top: 1px #9e9e9e solid; */
  border-bottom: 1px #9e9e9e solid;
  padding-right: 1rem;
}

.Next{
  /* border-top-right-radius:8px;
  border-bottom-right-radius:8px; */
  /* border-right: 1px #9e9e9e solid;
  border-top: 1px #9e9e9e solid; */
  border-bottom: 1px #9e9e9e solid;
  padding-left: 1rem;
}
.thisMonthButton{
  /* border-top: 1px #9e9e9e solid; */
  border-bottom: 1px #9e9e9e solid;
}
</style>

