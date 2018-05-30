<template>
    <div v-if="order != null" class="material-box">
        <div>
            {{ order.priority }} {{ order.name }}
        </div>
        <div>
            content
        </div>
    </div>
</template>

<script>
export default {
    name: 'order-detail',
    props: {
        order: null,
    }
}
</script>

<style scoped>
    
</style>
