<template>
    <div>
        <!-- <img v-bind="imageUrl"/> -->
        <p>{{ name }}</p>
        <span>{{ status }}</span>
    </div>
</template>

<script>
export default {
    name: 'equipment-card',
    data() {
        return {
            props: {
                name: null,
                imageUrl: null,
                status: null,
            }
        }
    }
}
</script>

<style>

</style>
