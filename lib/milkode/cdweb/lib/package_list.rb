# -*- coding: utf-8 -*-
#
# @file 
# @brief パッケージ一覧
# @author ongaeshi
# @date   2012/05/25

require 'milkode/cdweb/lib/database'

module Milkode
  class PackageList
    VIEW_NUM   = 7
    ADD_NUM    = 5
    UPDATE_NUM = 5
    FAV_NUM    = 7
    
    def initialize(grndb)
      @grndb = grndb
    end

    # topページへの表示数の調整は結構大切
    #   view   .. 7
    #   add    .. 5
    #   update .. 5
    #   fav    .. 5
    #
    def top_view
      grndb_list("viewtime", VIEW_NUM)
    end

    def top_add
      grndb_list("addtime", ADD_NUM)
    end

    def top_update
      grndb_list("updatetime", UPDATE_NUM)
    end

    def top_fav
      a = @grndb.packages.favs.map{|r| r.name}
      top_list(a[0...FAV_NUM], 'favtime')
    end

    def favorite_list
      names = @grndb.packages.favs.map{|r| r.name}

      names.map {|v|
        "<a href=\"/home/#{v}\">#{v}</a>"
      }.join("&nbsp;&nbsp;\n")
    end

    # ------------------------------------------------------
    private

    def grndb_list(column_name, num)
      a = @grndb.packages.sort(column_name).map {|r| r.name}
      top_list(a[0...num], column_name)
    end

    def top_list(list, column_name)
      list = list.map {|v|
        "  <li><a href=\"/home/#{v}\">#{v}</a></li>"
      }.join("\n")
      <<EOF
<ul class="unstyled_margin">
#{list}
<li><a href=\"/home?sort=#{column_name}">next >></a></li>
</ul>
EOF
    end
  end
end
