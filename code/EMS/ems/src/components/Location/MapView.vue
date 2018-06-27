<template>
    <div>
        <router-link to="/location">
            <a><i class="fa fa-chevron-left"></i> Back to Location</a>
        </router-link>
        <div v-if="mapViewSelectedLocation">
            <div v-if="!mapViewSelectedLocation.Blocks" style="margin-top: 1rem">
            This location has no block yet. <router-link v-if="authUser.RoleID == 2" :to="`/location/${$route.params.locationId}/add_block_floor_tile`"><a style="margin-left: .5rem; user-select: none;"><i class="fa fa-plus-circle"></i> Add new block</a></router-link>
            </div>
            <div v-else>
            <div :key="'mapViewBlock' + block.Id" v-for="block in mapViewSelectedLocation.Blocks">
                Block {{ block.Name }}
                <div :key="'mapViewFloor' + floor.Id" v-for="floor in block.Floors" style="padding-left: 1rem">
                Floor {{ floor.Name }}
                <div :key="'mapViewTile' + tile.Id" v-for="tile in floor.Tiles" style="padding-left: 1rem">
                    Tile {{ tile.Name }}
                </div>
                </div>
            </div>
            </div>
        </div>        
    </div>
</template>

<script>
import Server from '@/config/config';
export default {
    created() {
        let locationId = this.$route.params.locationId;
        let url = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}/${locationId}`;
        this.axios.get(url)
            .then((res) => {
                if (res.data) {
                    this.mapViewSelectedLocation = res.data;
                }
            })
            .catch((error) => {
                console.log(error);
            })
    },
    computed: {
        authUser() {
            return JSON.parse(window.localStorage.getItem('user'));
        }
    },
    data() {
        return {
            mapViewSelectedLocation: null,
        }
    }
}
</script>

<style>

</style>
