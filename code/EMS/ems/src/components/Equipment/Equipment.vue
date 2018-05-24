<template>
    <div>
        <h3>Equipment</h3>
        <div class="cards-wrapper">
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            <equipment-card name='Hammer' imageUrl='https://images.homedepot-static.com/productImages/25cf424d-4d30-4cf1-a370-4053f2cca3e7/svn/dewalt-specialty-hammers-dwht51138x-64_1000.jpg'></equipment-card>
            
        </div>
    </div>
</template>

<script>
import EquipmentCard from './EquipmentCard'

export default {
    components: {
        EquipmentCard
    }
}
</script>

<style>
    .cards-wrapper {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr;
    }
</style>
