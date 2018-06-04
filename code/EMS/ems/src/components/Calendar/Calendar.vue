<template>
    <div>
        <vue-full-calendar class="material-box material-shadow" :events="calendarEvents" locale="en"></vue-full-calendar>
    </div>
</template>

<script>
import data from '@/models/work_orders.js';
import VueFullCalendar from 'vue-fullcalendar';

export default {
    components: {
        VueFullCalendar
    },
    created() {
        for (var i = 0; i < data.length; i++) {
            var event = {
                title: data[i].name,
                start: data[i].endDate,
                end: data[i].endDate,
            }
            this.calendarEvents.push(event);
        }
    },
    data() {
        return {
            calendarEvents: [],
        }
    }
}
</script>

<style scoped>

</style>












































































































































































































































































     
    data() {
        return {
            calendarEvents: [],
        }
    }
}
</script>

<style>

</style>
