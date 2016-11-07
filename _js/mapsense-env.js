(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([''], function () {
            return (root.__env = factory());
        });
    } else if (typeof exports === 'object') {
        // Node. Does not work with strict CommonJS, but
        // only CommonJS-like enviroments that support module.exports,
        // like Node.
        module.exports = factory();
    } else {
        // Browser globals
        root.__env = factory();
    }
}(this, function () {
    return { "baseMapURL": "https://staging-tiles.mapsense.co/tilist/tile/", "baseURL": "https://staging.mapsense.co/", "cubeURL": "https://staging-cube.mapsense.co/", "__release": { "build_id": "1291faa6d6e7611d2ebffb24ba6a238857710ad03e5cfc5d8523d9bf4f2a81c3", "release": 32, "timestamp": 1431595093 } };
}));