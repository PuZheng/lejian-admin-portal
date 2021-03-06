var riot = require('riot');
var bus = require('riot-bus');
require('./centered-image.tag');
var toastr = require('toastr/toastr.min.js');
require('toastr/toastr.min.css');
var buildQS = require('build-qs');
require('tags/sortable-th.tag');
require('tags/checkbox-filter.tag');
require('tags/spu-type-table.tag');
require('tags/loader.tag');

<spu-type-list-app>
  <div class="list-app">
    <div class="ui top attached info message segment">
      <div class="ui header">
        SPU类型列表
      </div>
      <a class="ui tiny icon green circular button" href="/spu-type" data-content="创建SPU分类">
        <i class="icon plus"></i>
      </a>
      <div class="ui search">
        <div class="ui icon input">
          <input class="prompt" type="text" placeholder="按名称过滤..." name="search" onkeyup={ doSearch } value={ opts.ctx.query.kw }>
          <i class="search icon"></i>
        </div>
        <div class="results"></div>
      </div>
      <div riot-tag="checkbox-filter" checked_={ opts.ctx.query.onlyEnabled === '1' } label="仅展示激活" name="only_enabled" ctx={ opts.ctx }></div>
    </div>
    <div class="ui bottom attached segment">
      <loader if={ loading }></loader>
      <spu-type-table ctx={ opts.ctx }></spu-type-table>
    </div>
  </div>
  <script>
    var self = this;
    this.mixin(bus.Mixin);

    _.extend(self, {
      updating: [],
      updateHandlers: {
        weight: function (item) {
          return function (e) {
            if (self.updating.indexOf('weight') === -1) {
              self.updating.push('weight');
              setTimeout(function () {
                var patch = {
                  weight: $(e.target).val(),
                };
                bus.trigger('spuType.update', _.extend({}, item), patch);
                _.assign(item, patch);
                self.updating = self.updating.filter(function (i) {
                  return i != 'weight';
                });
              }, 500);
            }
          };
        }
      },
    });

    self.on('mount', function () {
      $(self.root).find('[data-content]').popup();
    }).on('spuType.list.fetching  spuType.deleting', function () {
      self.loading = true;
      self.update();
    }).on('spuType.list.fetch.done', function () {
      self.loading = false;
      self.update();
    });
    self.doSearch = function (e) {
      var kw = $(e.target).val();
      if (kw) {
        opts.ctx.query.kw = encodeURIComponent(kw);
      } else {
        delete opts.ctx.query.kw;
      }
      bus.trigger('go', '/spu-type-list?' + buildQS(opts.ctx.query));
    };
  </script>
</spu-type-list-app>
