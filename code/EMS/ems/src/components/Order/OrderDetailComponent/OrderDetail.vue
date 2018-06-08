<template>
    <div v-if="order != null" class="material-box material-shadow">
        <div class="detail">
            <div>
                <span class="detail-title">{{ order.ProjectName }}</span>
            </div>
            <div>
                <div>
                    Open -> Checked -> Approved -> Delivered -> Return ->  Done
                </div>
                Construction site:
                <img src="http://images.indianexpress.com/2016/11/hazaribagh-759.jpg" />
            </div>
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
    .detail {
        padding: .5rem 1rem;
    }

    .detail-title {
        font-size: 2rem;
    }

    .material-box:hover {
        cursor: auto !important;
    }
</style>
