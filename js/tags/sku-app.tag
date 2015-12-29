var riot = require('riot');
var bus = require('riot-bus');
require('tags/sku-form.tag');

<sku-app>
  <div class="ui grid object-app">
    <div class="row">
      <div class="column">
        <div class="ui top attached blue message">
          <div class="ui header">
            <raw if={ opts.ctx.params.id }>
              SKU详情-<i>{ item.spu.name }</i>
            </raw>
            <raw if={ !opts.ctx.params.id }>
              创建SKU
            </raw>
          </div>
          <i class="icon asterisk" if={ opts.ctx.params.id && editable }></i>
          <section class="ops">
            <a class="ui tiny circular icon green button" data-content="编辑对象" href={ opts.ctx.pathname + '?editable=1' } show={ opts.ctx.params.id && !editable }>
              <i class="icon edit"></i>
            </a>
            <a class="ui tiny circular icon button" data-content="锁定对象" href={ opts.ctx.pathname } show={ opts.ctx.params.id && editable }>
              <i class="icon lock"></i>
            </a>
          </section>
        </div>
        <div class="ui bottom attached segment">
          <sku-form editable={ editable } ctx={ opts.ctx}></vendor-form>
        </div>
      </div>
    </div>
  </div>
  <script>
    var self = this;
    self.mixin(bus.Mixin);

    self.on('update', function () {
      self.editable = !opts.ctx.params.id || self.opts.ctx.query.editable === '1';
    }).on('sku.fetched', function (item) {
      self.item = item;
      self.update();
    });
  </script>

</sku-app>
