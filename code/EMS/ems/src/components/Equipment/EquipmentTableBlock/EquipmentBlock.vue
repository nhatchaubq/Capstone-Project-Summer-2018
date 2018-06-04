<template>

    <tr >
            <td>#{{ equipmenttb.id }}</td>
            <td>{{ equipmenttb.equipmentName }}</td>
            <td>{{ equipmenttb.vendorName }}</td>
            <td>{{ equipmenttb.importDate }}</td>
            <td>{{ equipmenttb.price }}</td>
            <td>{{ equipmenttb.description }}</td>
            <td>{{ equipmenttb.Category }}</td>
    </tr>
           

</template>

<script>
export default {
    name: 'equipment-block',
    props: {
        equipmenttb: null,
    }
}
</script>

<style>

</style>
