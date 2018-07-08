<template>
    <div class="material-box  odbl">
    <!-- <div class="material-box material-shadow-animate odbl"> -->
        <div class="row">
            <div class="col-9" style="  font-size: 25px; font-weight: 500; margin-bottom: 5px;">{{ order.Name }}</div>
            <div class="col-3" style="margin-top:0.6rem; text-align: right"><strong>{{order.Detail.Quantity}}</strong> items</div>
        </div>
        <!-- <div class="order-status-icon">
           
            <i class="fa" :class="makeStatusIcon(order)"></i>            
        </div> -->
        <div class="order-block-info col-12">
            <div style="color: white" :style="`background-color: ${order.PriorityColor}`" class="tag">{{ order.Priority }}</div>
            <div >#{{ order.Id }}</div>
            <div>
                <i class="fa fa-user"></i>
                {{ order.RequestUsername }}
            </div>
            <!-- <div>
                <i class="fa fa-calendar"></i>
                {{ order.CreateDate }}
            </div> -->
        </div>
        <!-- <div class="order-status" :class="statusColor(order)">
            {{ order.WorkOrderStatus }}            
        </div> -->
        <div class="order-block-location col-12" style="padding-left: 0px !important">
            <i class="material-icons">location_on</i>
            {{ order.Location.Name }} - {{ order.Location.Address }}
        </div>
    </div>
</template>

<script>
export default {
  name: "order-block",
  props: {
    order: null
  },
  methods: {
    priorityBadgeColor(order) {
      let tagColor = order.PriorityColor;
      return `border: 1px solid ${tagColor}; background-color: ${tagColor}`;
    },
    makeStatusIcon(order) {
      switch (order.StatusID) {
        case 1: {
          // Requested
          return "fa-level-up requested";
        }
        case 2: {
          // Checked
          return "fa-check checked";
        }
        case 3: {
          // Approved
          return "fa-thumbs-up approved";
        }
        case 4: {
          // InProgress
          return "fa-handshake-o in-progress";
        }
        case 5: {
          // Closed
          return "fa-archive closed";
        }
        case 6: {
          // Rejected
          return "fa-check-square-o rejected";
        }
        case 1002: {
          // Cancelled
          return "fa-ban cancelled";
        }
      }
    },
    statusColor(order) {
      switch (order.StatusID) {
        case 1: {
          // Requested
          return "requested";
        }
        case 2: {
          // Checked
          return "checked";
        }
        case 3: {
          // Approved
          return "approved";
        }
        case 4: {
          // InProgress
          return "in-progress";
        }
        case 5: {
          // Closed
          return "closed";
        }
        case 6: {
          // Rejected
          return "rejected";
        }
        case 1002: {
          // Cancelled
          return "cancelled";
        }
      }
    }
  }
};
</script>

<style>
.order-block {
  /* display: grid; */
  /* grid-template-columns: 80% 20%; */
  /* grid-template-rows: 1 1 1; */
  margin-bottom: 1rem;
}

.order-block:hover {
  cursor: pointer;
}

.order-block-title {
  /* grid-column: 1; */
  /* grid-row: 1; */
  font-size: 25px;
  font-weight: 500;
  margin-bottom: 5px;
}

.order-status {
  /* line-height: 2.5rem; */
  font-size: 0.9rem;
  /* display: flex; */
  /* justify-content: center; */
  /* align-content: flex-end; */
  user-select: none;
}

.order-status-icon {
  font-size: 1.5rem;
  /* display: flex; */
  /* justify-content: center; */
  /* align-content: flex-start; */
  user-select: none;
}

.order-status-icon i {
  position: relative;
  top: 0.6rem;
}

/* .order-status i {
        position: relative;
        top: .4rem;
    } */

.order-block-info {
  /* grid-column: 1;
  grid-row: 2; */
  font-size: 14px;
  /* width: 100%; */
  /* display: flex; */
  /* align-content: center; */
  color: #616161;
  margin-bottom: 10px;
}

.order-block-info .badge {
  user-select: none;
}

.order-block-info div {
  padding: 0.1rem 0.4rem;
  margin-right: 10px;
}

.order-block-location {
  /* grid-column: 1; */
  /* grid-row: 3; */
  /* display: flex; */
  align-content: center;
  font-size: 14px;
  color: #616161;
}

.order-block-location i {
  font-size: 1rem;
  position: relative;
  top: 0.1rem;
}

.requested {
  color: #ef6c00;
}

.checked {
  color: #2196f3;
}

.approved {
  color: #43a047;
}

.rejected {
  color: var(--danger-color);
}

.in-progress {
  color: #795548;
}

.closed {
  color: #424242;
}

.cancel {
  color: var(--shadow);
}
.odbl {
  margin-bottom: 0.5rem;
}
</style>
