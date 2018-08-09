<template>

    <div>
        <!-- <vue-full-calendar class="material-box material-shadow" :events="calendarEvents" locale="en"></vue-full-calendar> -->
        <div class="title-gantt" style="display: grid;grid-template-columns: 72% auto;">
          <div class="gantt-name">
              List work order by month: 
            </div>
          <div class="gantt-info">
            <div class="" style="padding-top: 0.5rem">
              <h3>Today: {{today}}</h3>
            </div>
            <div class="note" style="padding-top: 0.5rem">
              <i class="fa fa-square" style="color:#7b1fa2; margin-left: 0.2rem"></i> Requested
              <i class="fa fa-square" style="color:#3f51b5; margin-left: 0.2rem"></i> Checked
              <i class="fa fa-square" style="color:#689f38; margin-left: 0.2rem"></i> Approved
              <i class="fa fa-square" style="color:#ffc107; margin-left: 0.2rem"></i> In Progress
              <i class="fa fa-square" style="color:#424242; margin-left: 0.2rem"></i> Closed
            </div>
            
          </div>
        </div>
        <div class="monthTab" style="align-items:center;justify-content:center;display:flex;padding-top:0.5rem">
          <div class="wrapper-button" style="display: grid; grid-template-columns: auto auto auto;font-size:18px">
            <button class="Previous" v-on:click="previousMonth()"><i class="fa fa-angle-left" style="color:gray;"></i> Pre </button>
            <button class="thisMonthButton" v-on:click="thisMonth()"> This_month </button>
            <button class="Next" v-on:click="nextMonth()"> Next <i class="fa fa-angle-right" style="color:gray;"></i></button>
          </div>
        </div>
        <div class="wrapper-gantt">  
          <croud-gantt :events="events"
              :start-period="startPeriod"
              :end-period="endPeriod"
              :index="index"
              :year="year"
               ></croud-gantt>
        </div>  
    </div>
</template>

<script>
import VueFullCalendar from "vue-fullcalendar";
import moment from "moment";

export default {
  components: {
    VueFullCalendar
  },
  created() {
    let authUser = JSON.parse(window.localStorage.getItem("user"));
    this.today = moment().format("DD-MM-YYYY");
    this.startPeriod = moment().startOf("month");
    this.endPeriod = moment().endOf("month");
    this.index = moment(this.startPeriod).month();
    this.year = moment(this.startPeriod).year();
    this.axios
      .get("http://localhost:3000/api/work_order/")
      .then(response => {
        let data = response.data.WorkOrders;
        this.orders = data;
        for (var i = 0; i < this.orders.length; i++) {
          this.startMonth = moment()
            .startOf("month")
            .valueOf();
          this.endMonth = moment()
            .endOf("month")
            .valueOf();
          var startOffset = 0;
          var duration = 0;
          // var CreateDate = moment(this.orders[i].CreateDate).valueOf();
          // var startdateChecked = moment(this.orders[i].StartDate).valueOf();
          var StartDate = moment(this.orders[i].StartDate).valueOf();
          var ExpectingCloseDate = moment(
            this.orders[i].ExpectingCloseDate
          ).valueOf();
          var ExpectingStartDate = moment(
            this.orders[i].ExpectingStartDate
          ).valueOf();
          var ClosedDate = moment(this.orders[i].ClosedDate).valueOf();

          // set stardate to find offset
          if (
            ExpectingStartDate >= this.startMonth &&
            ExpectingStartDate <= this.endMonth &&
            this.orders[i].StartDate == null
          ) {
            let timeDiffOffset = Math.abs(ExpectingStartDate - this.startMonth);
            startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
          } else if (
            ExpectingStartDate >= this.startMonth &&
            ExpectingStartDate <= this.endMonth &&
            this.orders[i].StartDate != null
          ) {
            // alert(this.orders[i].Name);
            let timeDiffOffset = Math.abs(StartDate - this.startMonth);
            startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
          }

          //set closedate to find duration
          if (this.orders[i].WorkOrderStatus == "Closed") {
            if (ClosedDate < this.endMonth && StartDate < this.startMonth) {
              var timeDiffDuration = Math.abs(ClosedDate - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ClosedDate < this.endMonth &&
              StartDate > this.startMonth
            ) {
              timeDiffDuration = Math.abs(ClosedDate - StartDate);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ClosedDate > this.endMonth &&
              StartDate < this.startMonth
            ) {
              timeDiffDuration = Math.abs(this.endMonth - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ClosedDate > this.endMonth &&
              StartDate > this.startMonth
            ) {
              timeDiffDuration = Math.abs(this.endMonth - StartDate);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
          if (this.orders[i].WorkOrderStatus == "In Progress") {
            if (
              ExpectingCloseDate < this.endMonth &&
              StartDate < this.startMonth
            ) {
              timeDiffDuration = Math.abs(ExpectingCloseDate - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate < this.endMonth &&
              StartDate > this.startMonth
            ) {
              timeDiffDuration = Math.abs(ExpectingCloseDate - StartDate);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              StartDate < this.startMonth
            ) {
              timeDiffDuration = Math.abs(this.endMonth - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              StartDate > this.startMonth
            ) {
              timeDiffDuration = Math.abs(this.endMonth - StartDate);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
          if (this.orders[i].WorkOrderStatus == "Checked") {
            if (
              ExpectingCloseDate < this.endMonth &&
              ExpectingStartDate < this.startMonth
            ) {
              timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate < this.endMonth &&
              ExpectingStartDate > this.startMonth
            ) {
              timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate < this.startMonth
            ) {
              timeDiffDuration = Math.abs(this.endMonth - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate > this.startMonth &&
              ExpectingStartDate < this.endMonth
            ) {
              timeDiffDuration = Math.abs(this.endMonth - ExpectingStartDate);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate > this.endMonth
            ) {
              timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
          if (this.orders[i].WorkOrderStatus == "Requested") {
            // alert(this.orders[i].Name);
            if (
              ExpectingCloseDate < this.endMonth &&
              ExpectingStartDate < this.startMonth
            ) {
              var timeDiffDuration = Math.abs(
                ExpectingCloseDate - this.startMonth
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate < this.endMonth &&
              ExpectingStartDate > this.startMonth
            ) {
              var timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate < this.startMonth
            ) {
              var timeDiffDuration = Math.abs(this.endMonth - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate > this.startMonth &&
              ExpectingStartDate < this.endMonth
            ) {
              var timeDiffDuration = Math.abs(
                this.endMonth - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate > this.endMonth
            ) {
              var timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }
          if (this.orders[i].WorkOrderStatus == "Approved") {
            if (
              ExpectingCloseDate < this.endMonth &&
              ExpectingStartDate < this.startMonth
            ) {
              var timeDiffDuration = Math.abs(
                ExpectingCloseDate - this.startMonth
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate < this.endMonth &&
              ExpectingStartDate > this.startMonth
            ) {
              var timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate < this.startMonth
            ) {
              var timeDiffDuration = Math.abs(this.endMonth - this.startMonth);
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate > this.startMonth &&
              ExpectingStartDate < this.endMonth
            ) {
              var timeDiffDuration = Math.abs(
                this.endMonth - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            } else if (
              ExpectingCloseDate > this.endMonth &&
              ExpectingStartDate > this.endMonth
            ) {
              var timeDiffDuration = Math.abs(
                ExpectingCloseDate - ExpectingStartDate
              );
              duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
            }
          }

          if (this.orders[i].ClosedDate != null) {
            this.orders[i].ClosedDate = moment(
              this.orders[i].ClosedDate
            ).format("DD-MM-YYYY");
          }
          if (this.orders[i].StartDate != null) {
            this.orders[i].StartDate = moment(this.orders[i].StartDate).format(
              "DD-MM-YYYY"
            );
          }
          if (
            (StartDate < this.startMonth && ClosedDate < this.startMonth) ||
            (StartDate > this.endMonth && ClosedDate > this.endMonth) ||
            (ExpectingStartDate > this.endMonth &&
              ExpectingCloseDate > this.endMonth)
          ) {
            // alert(i);
          } else {
            if (this.orders[i].WorkOrderStatus == "In Progress") {
              this.orders[i].WorkOrderStatus = "InProgress";
            }
            if (authUser.Role == "Staff") {
              if (this.orders[i].RequestUsername == authUser.Username) {
                var event = {
                  title: this.orders[i].Name,
                  offset: startOffset + 1,
                  duration: duration,
                  status: this.orders[i].WorkOrderStatus,
                  userRequest: this.orders[i].RequestUsername,
                  startDate: this.orders[i].StartDate,
                  dueDate: moment(this.orders[i].ExpectingCloseDate).format(
                    "DD-MM-YYYY"
                  ),
                  expectStartDate: moment(
                    this.orders[i].ExpectingStartDate
                  ).format("DD-MM-YYYY"),
                  team: this.orders[i].TeamLocation.Team.Name,
                  closedDate: this.orders[i].ClosedDate,
                  detail: this.orders[i].WorkOrderDetails,
                  location: this.orders[i].Location.Address
                };
                this.events.push(event);
              }
            } else {
              event = {
                title: this.orders[i].Name,
                offset: startOffset + 1,
                duration: duration,
                status: this.orders[i].WorkOrderStatus,
                userRequest: this.orders[i].RequestUsername,
                startDate: this.orders[i].StartDate,
                dueDate: moment(this.orders[i].ExpectingCloseDate).format(
                  "DD-MM-YYYY"
                ),
                expectStartDate: moment(
                  this.orders[i].ExpectingStartDate
                ).format("DD-MM-YYYY"),
                team: this.orders[i].TeamLocation.Team.Name,
                closedDate: this.orders[i].ClosedDate,
                detail: this.orders[i].WorkOrderDetails,
                location: this.orders[i].Location.Address
              };
              this.events.push(event);
            }
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
      endMonth: "",
      today: "",
      index: 0,
      year: "",
      Months: [
        "January",
        "Febuary",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ]
    };
  },
  methods: {
    previousMonth() {
      this.events = [];
      var date =
        moment(this.startPeriod).year() +
        "-0" +
        moment(this.startPeriod).month() +
        "-01";
      if (moment(this.startPeriod).month() == 0) {
        date = moment(this.startPeriod).year() - 1 + "-12" + "-01";
        this.year = this.year - 1;
      }
      // alert(date);
      this.startPeriod = moment(date).startOf("month");
      this.endPeriod = moment(date).endOf("month");
      this.startMonth = moment(date)
        .startOf("month")
        .valueOf();
      this.endMonth = moment(date)
        .endOf("month")
        .valueOf();
      this.index = moment(this.startPeriod).month();
      this.axios
        .get("http://localhost:3000/api/work_order/")
        .then(response => {
          let data = response.data.WorkOrders;
          this.orders = data;
          for (var i = 0; i < this.orders.length; i++) {
            var startOffset = 0;
            var duration = 0;
            // var CreateDate = moment(this.orders[i].CreateDate).valueOf();
            // var startdateChecked = moment(this.orders[i].StartDate).valueOf();
            var StartDate = moment(this.orders[i].StartDate).valueOf();
            var ExpectingCloseDate = moment(
              this.orders[i].ExpectingCloseDate
            ).valueOf();
            var ExpectingStartDate = moment(
              this.orders[i].ExpectingStartDate
            ).valueOf();
            var ClosedDate = moment(this.orders[i].ClosedDate).valueOf();

            // set stardate to find offset
            if (
              ExpectingStartDate >= this.startMonth &&
              ExpectingStartDate <= this.endMonth &&
              this.orders[i].StartDate == null
            ) {
              let timeDiffOffset = Math.abs(
                ExpectingStartDate - this.startMonth
              );
              startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
            } else if (
              ExpectingStartDate >= this.startMonth &&
              ExpectingStartDate <= this.endMonth &&
              this.orders[i].StartDate != null
            ) {
              let timeDiffOffset = Math.abs(StartDate - this.startMonth);
              startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
            }

            //set closedate to find duration
            if (this.orders[i].WorkOrderStatus == "Closed") {
              if (ClosedDate < this.endMonth && StartDate < this.startMonth) {
                var timeDiffDuration = Math.abs(ClosedDate - this.startMonth);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ClosedDate < this.endMonth &&
                StartDate > this.startMonth
              ) {
                timeDiffDuration = Math.abs(ClosedDate - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ClosedDate > this.endMonth &&
                StartDate < this.startMonth
              ) {
                timeDiffDuration = Math.abs(this.endMonth - this.startMonth);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ClosedDate > this.endMonth &&
                StartDate > this.startMonth
              ) {
                timeDiffDuration = Math.abs(this.endMonth - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "In Progress") {
              if (
                ExpectingCloseDate < this.endMonth &&
                StartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate < this.endMonth &&
                StartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(ExpectingCloseDate - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                StartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                StartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(this.endMonth - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "Checked") {
              // alert(this.orders[i].Name);
              if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.startMonth &&
                ExpectingStartDate < this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "Requested") {
              // alert(this.orders[i].Name);
              if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.startMonth &&
                ExpectingStartDate < this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "Approved") {
              if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.startMonth &&
                ExpectingStartDate < this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }

            if (this.orders[i].ClosedDate != null) {
              this.orders[i].ClosedDate = moment(
                this.orders[i].ClosedDate
              ).format("DD-MM-YYYY");
            }
            if (this.orders[i].StartDate != null) {
              this.orders[i].StartDate = moment(
                this.orders[i].StartDate
              ).format("DD-MM-YYYY");
            }
            if (
              this.orders[i].StartDate != null &&
              this.orders[i].ClosedDate != null
            ) {
              if (
                (StartDate < this.startMonth && ClosedDate < this.startMonth) ||
                (StartDate > this.endMonth && ClosedDate > this.endMonth)
              ) {
                // alert(i);
                // alert(this.orders[i].Name);
              } else {
                var event = {
                  title: this.orders[i].Name,
                  offset: startOffset + 1,
                  duration: duration,
                  status: this.orders[i].WorkOrderStatus,
                  userRequest: this.orders[i].RequestUsername,
                  startDate: this.orders[i].StartDate,
                  dueDate: moment(this.orders[i].ExpectingCloseDate).format(
                    "DD-MM-YYYY"
                  ),
                  expectStartDate: moment(
                    this.orders[i].ExpectingStartDate
                  ).format("DD-MM-YYYY"),
                  team: this.orders[i].TeamLocation.Team.Name,
                  closedDate: this.orders[i].ClosedDate,
                  detail: this.orders[i].WorkOrderDetails,
                  location: this.orders[i].Location.Address
                };
                this.events.push(event);
              }
            } else {
              if (
                (ExpectingStartDate < this.startMonth &&
                  ExpectingCloseDate < this.startMonth) ||
                (ExpectingStartDate > this.endMonth &&
                  ExpectingCloseDate > this.endMonth)
              ) {
                // alert(i);
                // alert(this.orders[i].Name);
              } else {
                if (this.orders[i].WorkOrderStatus == "In Progress") {
                  this.orders[i].WorkOrderStatus = "InProgress";
                }
                var event = {
                  title: this.orders[i].Name,
                  offset: startOffset + 1,
                  duration: duration,
                  status: this.orders[i].WorkOrderStatus,
                  userRequest: this.orders[i].RequestUsername,
                  startDate: this.orders[i].StartDate,
                  dueDate: moment(this.orders[i].ExpectingCloseDate).format(
                    "DD-MM-YYYY"
                  ),
                  expectStartDate: moment(
                    this.orders[i].ExpectingStartDate
                  ).format("DD-MM-YYYY"),
                  team: this.orders[i].TeamLocation.Team.Name,
                  closedDate: this.orders[i].ClosedDate,
                  detail: this.orders[i].WorkOrderDetails,
                  location: this.orders[i].Location.Address
                };
                this.events.push(event);
              }
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    nextMonth() {
      this.events = [];
      var nextMonth = moment(this.startPeriod).month() + 2;
      var date = moment(this.startPeriod).year() + "-0" + nextMonth + "-01";
      if (moment(this.startPeriod).month() == 11) {
        date = moment(this.startPeriod).year() + 1 + "-01" + "-01";
        this.year = this.year + 1;
      }
      this.startPeriod = moment(date).startOf("month");
      this.endPeriod = moment(date).endOf("month");
      this.startMonth = moment(date)
        .startOf("month")
        .valueOf();
      this.endMonth = moment(date)
        .endOf("month")
        .valueOf();
      this.index = moment(this.startPeriod).month();
      this.axios
        .get("http://localhost:3000/api/work_order/")
        .then(response => {
          let data = response.data.WorkOrders;
          this.orders = data;
          for (var i = 0; i < this.orders.length; i++) {
            var startOffset = 0;
            var duration = 0;
            // var CreateDate = moment(this.orders[i].CreateDate).valueOf();
            // var startdateChecked = moment(this.orders[i].StartDate).valueOf();
            var StartDate = moment(this.orders[i].StartDate).valueOf();
            var ExpectingCloseDate = moment(
              this.orders[i].ExpectingCloseDate
            ).valueOf();
            var ExpectingStartDate = moment(
              this.orders[i].ExpectingStartDate
            ).valueOf();
            var ClosedDate = moment(this.orders[i].ClosedDate).valueOf();

            // set stardate to find offset
            if (
              ExpectingStartDate >= this.startMonth &&
              ExpectingStartDate <= this.endMonth &&
              this.orders[i].StartDate == null
            ) {
              // alert(this.orders[i].Name);
              let timeDiffOffset = Math.abs(
                ExpectingStartDate - this.startMonth
              );
              startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
            } else if (
              ExpectingStartDate >= this.startMonth &&
              ExpectingStartDate <= this.endMonth &&
              this.orders[i].StartDate != null
            ) {
              // alert(this.orders[i].Name);
              let timeDiffOffset = Math.abs(StartDate - this.startMonth);
              startOffset = Math.floor(timeDiffOffset / (1000 * 3600 * 24));
            }

            //set closedate to find duration
            if (this.orders[i].WorkOrderStatus == "Closed") {
              if (ClosedDate < this.endMonth && StartDate < this.startMonth) {
                var timeDiffDuration = Math.abs(ClosedDate - this.startMonth);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ClosedDate < this.endMonth &&
                StartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(ClosedDate - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ClosedDate > this.endMonth &&
                StartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ClosedDate > this.endMonth &&
                StartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(this.endMonth - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "In Progress") {
              if (
                ExpectingCloseDate < this.endMonth &&
                StartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate < this.endMonth &&
                StartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(ExpectingCloseDate - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                StartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                StartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(this.endMonth - StartDate);
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "Checked") {
              // alert(this.orders[i].Name);
              if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.startMonth &&
                ExpectingStartDate < this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "Requested") {
              // alert(this.orders[i].Name);
              if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
                // alert(duration);
              } else if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.startMonth &&
                ExpectingStartDate < this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }
            if (this.orders[i].WorkOrderStatus == "Approved") {
              if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
                // alert(duration);
              } else if (
                ExpectingCloseDate < this.endMonth &&
                ExpectingStartDate > this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate < this.startMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - this.startMonth
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.startMonth &&
                ExpectingStartDate < this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  this.endMonth - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              } else if (
                ExpectingCloseDate > this.endMonth &&
                ExpectingStartDate > this.endMonth
              ) {
                var timeDiffDuration = Math.abs(
                  ExpectingCloseDate - ExpectingStartDate
                );
                duration = Math.floor(timeDiffDuration / (1000 * 3600 * 24));
              }
            }

            if (this.orders[i].ClosedDate != null) {
              this.orders[i].ClosedDate = moment(
                this.orders[i].ClosedDate
              ).format("DD-MM-YYYY");
            }
            if (this.orders[i].StartDate != null) {
              this.orders[i].StartDate = moment(
                this.orders[i].StartDate
              ).format("DD-MM-YYYY");
            }
            if (
              this.orders[i].StartDate != null &&
              this.orders[i].ClosedDate != null
            ) {
              if (
                (StartDate < this.startMonth && ClosedDate < this.startMonth) ||
                (StartDate > this.endMonth && ClosedDate > this.endMonth)
              ) {
                // alert(i);
                // alert(this.orders[i].Name);
              } else {
                var event = {
                  title: this.orders[i].Name,
                  offset: startOffset + 1,
                  duration: duration,
                  status: this.orders[i].WorkOrderStatus,
                  userRequest: this.orders[i].RequestUsername,
                  startDate: this.orders[i].StartDate,
                  dueDate: moment(this.orders[i].ExpectingCloseDate).format(
                    "DD-MM-YYYY"
                  ),
                  expectStartDate: moment(
                    this.orders[i].ExpectingStartDate
                  ).format("DD-MM-YYYY"),
                  team: this.orders[i].TeamLocation.Team.Name,
                  closedDate: this.orders[i].ClosedDate,
                  detail: this.orders[i].WorkOrderDetails,
                  location: this.orders[i].Location.Address
                };
                this.events.push(event);
              }
            } else {
              if (
                (ExpectingStartDate < this.startMonth &&
                  ExpectingCloseDate < this.startMonth) ||
                (ExpectingStartDate > this.endMonth &&
                  ExpectingCloseDate > this.endMonth)
              ) {
                // alert(i);
                // alert(this.orders[i].Name);
              } else {
                if (this.orders[i].WorkOrderStatus == "In Progress") {
                  this.orders[i].WorkOrderStatus = "InProgress";
                }
                var event = {
                  title: this.orders[i].Name,
                  offset: startOffset + 1,
                  duration: duration,
                  status: this.orders[i].WorkOrderStatus,
                  userRequest: this.orders[i].RequestUsername,
                  startDate: this.orders[i].StartDate,
                  dueDate: moment(this.orders[i].ExpectingCloseDate).format(
                    "DD-MM-YYYY"
                  ),
                  expectStartDate: moment(
                    this.orders[i].ExpectingStartDate
                  ).format("DD-MM-YYYY"),
                  team: this.orders[i].TeamLocation.Team.Name,
                  closedDate: this.orders[i].ClosedDate,
                  detail: this.orders[i].WorkOrderDetails,
                  location: this.orders[i].Location.Address
                };
                this.events.push(event);
              }
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    thisMonth() {
      this.startPeriod = moment().startOf("month");
      this.endPeriod = moment().endOf("month");
      this.startMonth = moment()
        .startOf("month")
        .valueOf();
      this.endMonth = moment()
        .endOf("month")
        .valueOf();
      location.reload();
    }
  },
  watch: {
    addPopUp: function() {}
  }
};
</script>

<style scoped>
.Previous {
  /* border-top-left-radius:8px;
  border-bottom-left-radius:8px; */
  /* border-left: 1px #9e9e9e solid;
  border-top: 1px #9e9e9e solid; */
  border-bottom: 1px #9e9e9e solid;
  padding-right: 1rem;
}

.Next {
  /* border-top-right-radius:8px;
  border-bottom-right-radius:8px; */
  /* border-right: 1px #9e9e9e solid;
  border-top: 1px #9e9e9e solid; */
  border-bottom: 1px #9e9e9e solid;
  padding-left: 1rem;
}
.thisMonthButton {
  /* border-top: 1px #9e9e9e solid; */
  border-bottom: 1px #9e9e9e solid;
}
.gantt-name {
  font-size: 28px;
  color: var(--dark-background);
}
.wrapper-gantt {
  padding-top: 1rem;
}
.gantt-info {
  align-items: right;
  justify-content: right;
  display: table-row;
}
</style>

