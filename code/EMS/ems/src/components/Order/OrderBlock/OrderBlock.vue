<template>
    <div v-if="order" class="material-box material-shadow-animate order-block">
        <div class="order-block-title" :class="{'error-text': !order.ClosedDate && (getDurationFromToday(order.ExpectingCloseDate) < 0),
                                                'warning-text': !order.ClosedDate && (getDurationFromToday(order.ExpectingCloseDate) <= 3 && getDurationFromToday(order.ExpectingCloseDate) >= 0)}"
            style="font-size: 1.4rem !important; font-style: normal; font-weight: 500 !important;">{{ order.Name }}</div>
        <div class="order-status-icon" style="display: grid; grid-template-row: auto auto; text-align: center">
            <!-- <i class="material-icons">lock_open</i> -->
            <div style="margin-top: -.5rem; margin-bottom: 1rem">
                <i class="fa" :class="makeStatusIcon(order)"></i>
            </div>
            
            <div class="order-status" style="font-weight: 500;" :class="statusColor(order)">
                {{ order.WorkOrderStatus }}            
            </div>
        </div>
        <div class="order-block-info" style="">
            <div class="row" style="margin-left: 0; margin-right: 0">
                <div style="color: white" :style="`background-color: ${order.PriorityColor}`" class="tag">{{ order.Priority }}</div>
                <div>#{{ order.Id }}</div>
                <div>
                    <i class="fa fa-user"></i>
                    {{ authUser.Id == order.RequestUserID ? 'You' : order.RequestUsername }}<span v-if="order.TeamLocation"> ({{ order.TeamLocation.Team.Name }})</span>
                </div>
                <div>
                    <i class="fa fa-calendar-plus-o"></i>
                    {{ getFormatDate(order.CreateDate) }}
                </div>
            </div>
        </div>
        <div class="order-block-location" v-if="order.TeamLocation">
            <i class="material-icons">location_on</i>
            {{ order.TeamLocation.Location.Name }} - {{ order.TeamLocation.Location.Address }}
        </div>
    </div>
</template>

<script>
import moment from 'moment';
export default {
    name: 'order-block',
    props: {
        order: null,
    },
    computed: {
        authUser() {
            return JSON.parse(window.localStorage.getItem('user'));
        }
    },
    methods: {
        priorityBadgeColor(order) {
            let tagColor = order.PriorityColor;
            return `border: 1px solid ${tagColor}; background-color: ${tagColor}`;
        },
        makeStatusIcon(order) {
            switch(order.WorkOrderStatus) {
                case 'Requested': { // Requested
                    return 'fa-level-up requested';
                }
                case 'Checked': { // Checked
                    return 'fa-check checked';
                }
                case 'Approved': { // Approved
                    return 'fa-thumbs-up approved';
                }
                case 'Rejected': { // 
                    return 'fa-thumbs-down rejected';
                }
                case 'In Progress': { // 
                    return 'fa-tasks in-progress';
                }
                case 'Closed': { // 
                    return 'fa-archive closed';
                }
                case 'Cancelled': { // Cancelled
                    return 'fa-ban cancelled';
                }
            }
        },
        statusColor(order) {
            switch(order.WorkOrderStatus) {
                case 'Requested': { // Requested
                    return 'requested';
                }
                case 'Checked': { // Checked
                    return 'checked';
                }
                case 'Approved': { // Approved
                    return 'approved';
                }
                case 'Rejected': { // InProgress
                    return 'rejected';
                }
                case 'In Progress': { // Closed
                    return 'in-progress';
                }
                case 'Closed': { // Rejected
                    return 'closed';
                }
                case 'Cancelled': { // Cancelled
                    return 'cancelled';
                }
            }
        },
        getFormatDate(date) {
            return moment(date).format('L');
        },
        getFormatDateTime(date) {
            return moment(date).format('LLL');
        },        
        getDurationFromToday(toDate) {
            return moment(toDate).diff(moment(), 'days');
        },
        getDate(date) {
            return moment(date);
        },
        getToday() {
            return moment();
        },
    }
}
</script>

<style>
    .order-block {
        display: grid;
        grid-template-columns: 80% 20%;
    }

    .order-block:hover {
        cursor: pointer;
    }

    .order-block-title {
        grid-column: 1;
        grid-row: 1;
        font-size: 1.2rem;
        font-weight: 500;
        margin-bottom: 5px;
    }

    .order-status {
        /* line-height: 2.5rem; */
        font-size: .9rem;
        user-select: none;
    }

    .order-status-icon {
        font-size: 1.5rem;
        user-select: none;
    }

    /* .order-status i {
        position: relative;
        top: .4rem;
    } */

    .order-block-info {
        grid-column: 1;
        grid-row: 2;
        font-size: 14px;
        width: 100%;
        /* display: flex; */
        /* align-content: center; */
        color: #616161;
        margin-bottom: 10px;        
    }

    .order-block-info .badge {
        user-select: none;
    }

    .order-block-info div {
        padding: .1rem 0.1rem;
        /* margin-right: 10px; */
    }

    .order-block-location {
        grid-column: 1;
        grid-row: 3;        
        display: flex;
        align-content: center;
        font-size: 14px;        
        color: #616161;        
    }

    .order-block-location i {
        font-size: 1rem;
        position: relative;
        top: .15rem;
    }

    .requested {
        color: var(--status-requested);
    }

    .checked {
        color: var(--status-checked);
    }

    .approved {
        color: var(--status-approved);
    }

    .rejected {
        color: var(--status-rejected);
    }

    .in-progress {
        color: var(--status-in-progress);
    }

    .closed {
        color: var(--status-closed);
    }

    .cancelled {
        color: var(--status-cancelled);
    }
</style>
