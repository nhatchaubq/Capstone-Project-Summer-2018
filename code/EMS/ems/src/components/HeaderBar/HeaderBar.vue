<template>
    <div class="headerbar columns">
        <div class="column">
            <div class="headerbar-title">
                {{ title }}
            </div>
        </div>
        <div class="column"></div>
        <div class="column is-4">
            <div class="headerbar-end">
                <div class="searchbar-wrapper">
                    <i class="fa fa-search"></i>
                    <input type="text" class="searchbar" placeholder="Search"/>
                </div>
                <div>
                    <div class="headerbar-button">
                        <i class="material-icons">star</i>
                    </div>
                </div>
                <div>
                    <div class="headerbar-button">
                        <i class="material-icons">notifications</i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'header-bar',
    data() {
        return {
            title: 'Title',
        }
    }
}
</script>

<style>
    .headerbar {
        /* display: grid;
        grid-template-columns: 20% 40% 40%; */
        height: 5rem;
        /* background-color: var(--light-background); */
        background-color: #b0bec5;
        border-bottom: 2px solid var(--dark-background);
    }

    .headerbar-title {
        padding: 0.5rem 0 0 2rem;
        font-size: 40px;
        color: var(--dark-background);
        /* font-weight: bold; */
    }
    
    .headerbar-end {
        display: flex;
        justify-content: center;
        align-content: center;
        padding-top: .3rem;
        /* display: grid;
        grid-template-columns: 70% 15% 15%; */
        /* grid-column-gap: 10px; */
        /* padding-right: 1rem; */
        /* display: flex; */
    }

    .searchbar-wrapper {
        margin-top: 0.7rem;
        margin-right: 20px;
    }

    .searchbar {
        /* border: none !important; */
        /* display: flex; */
        margin-left: -40px;
        /* border: 1px solid #bdbdbd; */
        background-color: var(--light-background);
        border: 1px solid var(--light-background);
        border-radius: 5px;
        padding: 5px 10px 5px 40px;
        box-shadow: 0px 0px 0px #e0e0e0;
        transition: all 0.25s ease-in;
        font-style: italic;
        width: 100%;
    }

    .searchbar-wrapper i {
        position: relative;
        padding: 10px;
        color: #9e9e9e;
        z-index: 1;
        /* transition: all 0.25s ease-in-out; */
    }

    .searchbar:hover, .searchbar-wrapper input:focus {
        /* border: 1px solid #eeeeee;
        box-shadow: 3px 3px 5px #9e9e9e;   */
    }

    .headerbar-button {
        margin-top: 0.7rem;
        user-select: none;
        color: #424242;
        border: 1px solid black;
        /* background-color: #e0e0e0; */
        text-align: center;
        width: 35px;
        height: 35px;
        border-radius: 50%;
        box-shadow: 0px 0px 0px #e0e0e0;
        transition: all .25s ease-in;
        margin-right: 10px;
    }

    .headerbar-button i {
        position: relative;
        top: 5px;
        transition: all .25s ease-in;        
    }

    .headerbar-button:hover {
        border: 1px solid var(--primary-color);
        background-color: var(--primary-color);
        box-shadow: 3px 3px 5px #bdbdbd;  
        cursor: pointer;        
    }

    .headerbar-button:hover i {
        color: white;    }
</style>
