var riot = require('riot');
var bus = require('riot-bus');
var request = require('request');
var buildQS = require('build-qs');

var RetailerStore = function () {
    riot.observable(this);
    this.on('retailer.list.fetch', function (query) {
        this.fetchList(query);
    });
    return this;
};

RetailerStore.prototype.fetchList = function (query) {
    var d = $.Deferred();
    query = query || {};

    bus.trigger('retailer.list.fetching');

    request('/retailer-list?' + buildQS(query)).done(function (res) {
        bus.trigger('retailer.list.fetched', res.body);
        bus.trigger('retailer.list.done');
        d.resolve(data);
    }).fail(function (err, res) {
        bus.trigger('retailer.list.fetch.failed', err);
        bus.trigger('retailer.list.fetch.done');
        d.reject(err);
    });

    return d;
};


module.exports = new RetailerStore();
