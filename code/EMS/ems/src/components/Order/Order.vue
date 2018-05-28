<template>
    <div>
        <div class="order-navigator-buttons">
            <button class="is-active">All</button>
            <button class="">Open</button>
            <button class="">Upcoming</button>
            <button class="">Checked</button>
            <button class="">Overdue</button>
        </div>
        <div class="order-content">
            <div class="order-block">
                <div class="order-block-title">Hammer - Vinhomes</div>
                <div class="order-block-info">
                    <div class="badge">High</div>
                </div>
                <div class="order-block-location">a</div>
            </div>
        </div>
        <button id="btn-add-work-order">Add Work Order</button>
    </div>
</template>

<script>
export default {
    name: 'work-order',
    data() {
        return {

        }
    }
}
</script>

<style>
    .order-navigator-buttons {
        display: flex;
        justify-content: center;
        align-content: center;
    }

    .order-navigator-buttons > button {
        width: 7rem;
        margin: 0 1rem 0 1rem;
        padding: 0.5rem 0 0.5rem 0;
        /* background-color: aqua; */
        font-size: 1.2rem;
    }

    .is-active {
        border-bottom: 1px solid black;
        font-weight: bold;
    }

    #btn-add-work-order {
        position: fixed;
        right: 3rem;
        bottom: 2rem;
        background-color: var(--primary-color);
        padding: 13px;
        color: white;
        border-radius: 10px;
        box-shadow: 4px 4px 5px #bdbdbd;
        z-index: 1;
    }

    #btn-add-work-order:hover {
        cursor: pointer;
    }

    .order-content {
        margin-top: 3rem;
    }

    .order-block {
        display: grid;
        grid-template-columns: 80% 20%;
        grid-template-rows: 1 1 1;
        background-color: #fafafa;
        border-radius: 3px;
        border-left: 4px solid #f44336;
        padding: .3rem 1rem;
        box-shadow: 3px 3px 5px #bdbdbd;
        margin: 0 5rem;
    }

    .order-block > div {
        margin-bottom: 10px;
    }

    .order-block-title {
        grid-column: 1;
        grid-row: 1;
        font-size: 25px;
        font-weight: 500;
    }

    .order-block-info {
        grid-column: 1;
        grid-row: 2;
        font-size: 13px;
    }


    .order-block-info div {
        padding: .1rem .3rem;
    }

    .badge {
        border: 1px solid var(--danger-color);
        background-color: var(--danger-color);
        color: white;
        border-radius: 5px;
    }

    .order-block-location {
        grid-column: 1;
        grid-row: 3;
    }
    
</style>
