# 存储网关-ceph

### 声明

<a href="http://www.youruncloud.com" target="_blank">深圳市云舒网络技术有限公司</a>对此模板、此模板相关镜像、及镜像内标识有我司版权声明的脚本和程序拥有版权，受法律保护。

未经本公司书面许可，任何单位及个人不得以任何方式或理由对上述产品、服务、信息、材料的任何部分进行使用、复制、修改、抄录、传播或与其它产品捆绑使用、销售。

凡侵犯本公司版权的，本公司必依法追究其法律责任。

对于其镜像内涉及的第三方软件、组件、库文件，相关版权属于第三方公司、组织或人员所拥有，本镜像仅提供试用功能。

### 概述

此模板仅用于试用，在创建卷时有限制，如需要在生产环境使用版本，请联系<a href="http://www.youruncloud.com" target="_blank">有容云</a>。
将基于AppSoar安装应用存储网关-ceph，建议最小安装为2G内存，支持docker 1.10.3以上版本, Linux ubuntu14 4.2.0-27-generic以上版本。

### 配置

默认配置如下，配置详细描述请点击<a href="http://docs.youruncloud.com/#appsoarcatalog/ceph/readme.html" target="_blank">此处</a>。

### 使用

1.从catalog选择存储网关-ceph
2.输入配置项中必填信息(或使用默认配置)
3.点击运行，开始部署

部署完成后，可以使用添加容器的方式创建ceph存储卷，并在指定的容器中对其进行使用（读写），已创建的卷可以在相应的存储池中实时查看其状态信息。
使用详细描述请点击<a href="http://docs.youruncloud.com/#appsoarcatalog/ceph/readme.html" target="_blank">此处</a>。

