# frozen_string_literal: true

module Echarts
  def self.line_options
    {
      title: {
        # text: 'ECharts title' # To Be Merged
      },
      tooltip: {
        trigger: 'axis'
      },
      legend: {
        bottom: 0
        # data: %w[销量 价格] # To Be Merged
      },
      toolbox: {
        orient: 'vertical',
        show: true,
        feature: {
          saveAsImage: {}
        }
      },
      xAxis: {
        axisLabel: {
          interval: 0
        }
        # data: %w[衬衫 羊毛衫 雪纺衫 裤子 高跟鞋 袜子] # To Be Merged
      },
      yAxis: {},
      series: [
        # {
        #   name: '销量',
        #   type: 'line',
        #   data: [5, 20, 36, 10, 0, 20]
        # }
        # To Be Merged
      ]
    }
  end

  def self.tree_options
    {
      series: [
        {
          type: 'tree',
          data: [],
          symbolSize: 7,
          label: {
            normal: {
              position: 'left',
              verticalAlign: 'middle',
              align: 'right'
            }
          },
          leaves: {
            label: {
              normal: {
                position: 'right',
                verticalAlign: 'middle',
                align: 'left'
              }
            }
          }
        }
      ]
    }
  end
end
