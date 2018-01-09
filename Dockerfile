FROM jupyter/scipy-notebook

USER root

ENV SHELL=/bin/bash \
    NB_USER=edu \
    NB_UID=1001 \
    NB_GID=100

ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

USER $NB_USER

RUN fix-permissions /home/$NB_USER

WORKDIR $HOME

COPY ./home .

USER root

RUN fix-permissions *

RUN fix-permissions /etc/jupyter/

RUN find .

USER $NB_USER
