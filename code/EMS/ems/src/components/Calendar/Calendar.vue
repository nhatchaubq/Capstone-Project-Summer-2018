<template>
    <div>
        <vue-full-calendar v-bind:events="calendarEvents" locale="en"></vue-full-calendar>
    </div>
</template>

<script>
import data from '@/models/work_orders.js';
import VueFullCalendar from 'vue-fullcalendar';

export default {
    components: {
        VueFullCalendar
    },
    beforeCreate() {
        for (var i = 0; i < data.length; i++) {
            let event = {
                title: data[i].name,
                startDate: data[i].startDate,
                endDate: data[i].endDate,
            };
            this.calendarEvents.push(event);
        }
    },
    // cr












































































































































































































































































     
    data() {
        return {
            calendarEvents: [],
        }
    }
}
</script>

<style>

</style>
