var riot = require('riot');
var bus = require('riot-bus');
var moment = require('moment');

require('tags/sortable-th.tag');

<vendor-table>
  <table class="ui sortable compact striped table">
    <thead class="full-width">

      <th riot-tag="sortable-th" label="编号" name="id" ctx={ opts.ctx }></th>
      <th>名称</th>
      <th>激活</th>
      <th>电话</th>
      <th>地址</th>
      <th>企业主页</th>
      <th>邮箱</th>
      <th>微博号</th>
      <th>微博主页</th>
      <th>微信号</th>
      <th riot-tag="sortable-th" label="创建时间" name="create_time" ctx={ opts.ctx }></th>

    </thead>
    <tbody class="full-width">
      <tr each={ item in items } data-item-id={ item.id }>

        <td>
          <a href="/vendor/{item.id}">{ item.id }</a>
        </td>
        <td>{ item.name }</td>
        <td>
          <i class="ui icon { item.enabled? 'green checkmark': 'red remove' }"></i>
        </td>
        <td>{ item.tel }</td>
        <td>{ item.addr }</td>
        <td>
          <a href={ item.website } target="_blank">{ item.website }</a>
        </td>
        <td>{ item.email }</td>
        <td>{ item.weiboUserId }</td>
        <td>
          <a href="{ item.weiboHomepage }" target="_blank">{ item.weiboHomepage }</a>
        </td>
        <td>{ item.weixinAccount }</td>
        <td>{ moment(item.createTime).format('YY-MM-DD HH时') }</td>

      </tr>
    </tbody>
  </table>
  <script>
    var self = this;
    self.mixin(bus.Mixin);
    self.moment = moment;

    self.on('vendor.list.fetched', function (data) {
      self.items = data.data;
      self.update();
    });
  </script>

</vendor-table>
