layui.define(['jquery'], function (exports) {
    'use strict';

    var $ = layui.jquery;
    var obj = {
        /**
         * 创建
         * @param data  json 数据
         * @param ele   容器
         * @param current
         */
        make: function (data, ele, current) {
            var html = ''
                , data_length = data.length
                , percentage = 100 / data_length;

            for (var i = 0; i < data_length; i++) {
                var icon = ''
                    , tail = '';
                if (i < current) {
                    icon = 'layui-icon-ok';
                    tail = 'step-item-tail-done';
                }

                var temp = '<div class="step-item" style="width: ' + percentage + '%;">';

                if (parseInt(i) + 1 < data_length) {
                    temp += '<div class="step-item-tail"><i class="' + tail + '"></i></div>';
                }

                if (icon) {
                    temp += '<div class="step-item-head"><i class="layui-icon ' + icon + '"></i></div>';
                } else {
                    temp += '<div class="step-item-head step-item-head-active"><i class="layui-icon">' + (parseInt(i) + 1) + '</i></div>'
                }
                temp += '<div class="step-item-main"><div class="step-item-main-title">' + data[i].title + '</div><div class="step-item-main-desc">' + data[i].desc + '</div></div></div>';

                html += temp;
            }

            $(ele).append(html);
        }
    };

    exports('steps', obj);
});