FROM jupyter/scipy-notebook

USER root

RUN pip install jupyter_contrib_nbextensions

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

USER $NB_USER
RUN jupyter contrib nbextension install --user
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable latex_envs/latex_envs
RUN jupyter nbextension enable freeze/main
COPY ./notebook.json /home/edu/.jupyter/nbconfig/.
RUN find .
