function sleep(milis) {
    return new Promise(callback => setTimeout(callback, milis));
}

export default {
    sleep,
}