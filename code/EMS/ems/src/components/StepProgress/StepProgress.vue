<template>
    <div v-if="statusList">
        <ul class="progressbar">
            <!-- workOrderStatus rejected - 6 or cancelled - 1002 -->
            <div v-if="workOrderStatus.name == 'Cancelled'">
                <li class="tag" :class="getStatusColorClass(workOrderStatus.name)">
                    {{ workOrderStatus.name }}
                </li>
            </div> <!-- workOrderStatus rejected - 6 or cancelled - 1002 -->
            <div v-else>
                <li class="tag" :class="status.id <= orderStatus.id ? getStatusColorClass(status.name) : ''" :key="'step' + status.id" v-for="status in statuses" :value="status.name">
                    {{ status.name }}
                </li>
            </div>
        </ul>
    </div>
</template>

<script>
export default {
  name: "step-progress",
  props: {
    workOrderStatus: null,
    statusList: null,
    lastOrderStatus: null,
  },
  data() {
    return {
      orderStatus: null,
      statuses: []
    };
  },
  created() {
    this.orderStatus = this.workOrderStatus;
  },
  methods: {
    getStatusColorClass(statusName) {
      switch (statusName) {
        case "Requested":
          return "requested";
        case "Checked":
          return "checked";
        case "Approved":
          return "approved";
        case "Rejected":
          return "rejected";
        case "In Progress":
          return "in-progress";
        case "Closed":
          return "closed";
        case "Cancelled":
          return "cancelled";
      }
    }
  },
  watch: {
    workOrderStatus: function() {
      this.orderStatus = this.workOrderStatus;
    },
    statusList: function() {
      if (this.statusList) {
        this.statuses = JSON.stringify(this.statusList);
        this.statuses = JSON.parse(this.statuses);
        if (this.workOrderStatus && this.workOrderStatus.name == "Rejected") {
          if (this.lastOrderStatus && this.lastOrderStatus.Name == 'Requested') {
            this.statuses = this.statuses.filter(status => status.name != "Rejected");
            this.orderStatus.id = 2;
            // let checkedStatus = this.statuses.filter(s => s.name == 'Checked')[0];
            // console.log(checkedStatus)
            if (this.statuses.filter(s => s.name == 'Checked')[0]) {
              this.statuses[1].name = 'Rejected';
            }
          } else if (this.lastOrderStatus && this.lastOrderStatus.Name == 'Checked') {
            this.statuses = this.statuses.filter(status => status.name != "Approved");
          }
        } else {
          this.statuses = this.statuses.filter(status => status.name != "Rejected");
        }
      }
    }
  }
};
</script>

<style scoped>
.progressbar {
  width: 100%;
  user-select: none;
}
.progressbar li {
  border: 1px solid #f5f5f5;
  position: relative;
  /* float: left; */
  display: inline;
  margin-right: 4%;
  text-align: center;
  font-size: 13px;
  z-index: 3;
  /* border: 1px solid var(--primary-color);
        border-radius: 10px; */
  padding: 0.2rem 0.4rem;
}

.progressbar li:last-child {
  margin: 0 !important;
}

.progressbar li:after {
  content: "";
  width: 40%;
  height: 3px;
  background: #f5f5f5;
  z-index: -1;
  position: absolute;
  top: 0.6rem;
  margin-left: 0;
}

.progressbar li:last-child:after {
  content: none;
}

li.active {
  /* background-color: var(--primary-color) !important;
        border: 1px solid var(--primary-color) !important;        
        color: white; */
}

li.requested:after {
  background: var(--status-requested);
}

li.requested:after {
  background: var(--status-requested);
}

li.checked:after {
  background: var(--status-checked);
}

li.approved:after {
  background: var(--status-approved);
}

li.in-progress:after {
  background: var(--status-in-progress);
}

li.closed:after {
  background: var(--status-closed);
}

li.cancelled:after {
  background: var(--status-cancelled);
}

li.requested + li.checked {
  border: 1px solid var(--status-checked) !important;
}

li.checked + li.approved {
  border: 1px solid var(--status-approved) !important;
}

li.approved + li {
  border: 1px solid var(--status-in-progress) !important;
}

li.in-progress + li {
  border: 1px solid var(--status-closed) !important;
}
</style>
