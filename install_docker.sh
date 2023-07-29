#!/bin/bash

# 停止
sudo systemctl stop docker

# 卸载
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  docker-ce \
                  docker-ce-cli \
                  containerd.io \
                  -y

# 删除相关项
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker

# 删除docker库
sudo rm -f /etc/yum.repos.d/docker-ce.repo

# 清除缓存
sudo yum clean all

# 安装依赖项
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# 设置存储库
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 更新 yum 缓存
sudo yum makecache fast

# 安装 Docker 和 Docker Compose
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# 启动 Docker 服务
sudo systemctl start docker

# 验证 Docker 版本
docker version

# 验证 Docker Compose 版本
docker compose version

# 设置 Docker 开机自启
sudo systemctl enable docker

# 查看 Docker 状态
sudo systemctl status docker

# 修改源为阿里云的源
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://ll70j65t.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker