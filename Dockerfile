FROM debian

# Install required packages
RUN apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove
RUN apt-get install -y tzdata procps python3 python3-pip

# Install Jupyter
RUN pip3 install jupyter
RUN pip3 install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension

# Install JupyterLab
RUN pip3 install jupyterlab && jupyter serverextension enable --py jupyterlab

ENV LANG=C.UTF-8

# Adjust Timezone -- https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes
# # equivale a:
# #    cat /etc/localtime
# #    dpkg-reconfigure tzdata
#
# ENV TZ=America/Sao_Paulo
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#

# Expose Jupyter port & cmd
EXPOSE 8888
RUN mkdir -p /opt/app/data
RUN ln -s /opt/app/conf /root/.jupyter
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root
