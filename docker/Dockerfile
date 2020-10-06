# ARG usage in FROMs has to go up here in global

ARG jupyterq_img=kxsys/jupyterq:latest
ARG nlp_img=kxsys/nlp:latest
ARG ml_img=kxsys/ml:latest
ARG automl_img=kxsys/automl:latest

####
FROM $nlp_img AS nlp
FROM $ml_img AS ml
FROM $automl_img AS automl
FROM $jupyterq_img AS jupyterq

FROM jupyterq AS mlnotebooks

COPY requirements.txt README.md /opt/kx/mlnotebooks/
COPY data/ /opt/kx/mlnotebooks/data/
COPY notebooks/ /opt/kx/mlnotebooks/notebooks/
COPY utils/ /opt/kx/mlnotebooks/utils/
#hack, better way, tensorflow-gpu should be used if possible
RUN sed -i s/tensorflow-gpu/tensorflow/g /opt/kx/mlnotebooks/requirements.txt

# do not clean here, its cleaned later!
RUN apt-get update \
	&& apt-get -yy update

ARG port=8888
ENV PORT=${port}
EXPOSE ${port}/tcp

COPY --from=nlp /opt/kx/nlp/ /opt/kx/nlp/
COPY --from=nlp /opt/kx/q/nlp/ /opt/kx/q/nlp/

COPY --from=ml /opt/kx/ml/ /opt/kx/ml/
COPY --from=ml /opt/kx/q/ml/ /opt/kx/q/ml/

COPY --from=automl /opt/kx/automl/ /opt/kx/automl/
COPY --from=automl /opt/kx/q/automl/ /opt/kx/q/automl/


ARG VCS_REF=dev
ARG BUILD_DATE=dev

LABEL	org.label-schema.schema-version="0.1" \
	org.label-schema.name=jupyterq \
	org.label-schema.description="Machine Learning notebook examples for kdb+" \
	org.label-schema.vendor="Kx" \
	org.label-schema.license="Apache-2.0" \
	org.label-schema.url="https://code.kx.com/q/ml/" \
	org.label-schema.version="${VERSION:-dev}" \
	org.label-schema.vcs-url="https://github.com/KxSystems/mlnotebooks.git" \
	org.label-schema.vcs-ref="$VCS_REF" \
	org.label-schema.build-date="$BUILD_DATE" \
	org.label-schema.docker.cmd="docker run -it -v 8888:8888 kxsys/nlp"

RUN apt-get -yy --no-install-recommends install build-essential \
	&& apt-get clean \
	&& find /var/lib/apt/lists -type f -delete

RUN chown -R kx:kx /opt/kx/mlnotebooks 

USER kx
# jupyterq is the base, install requirements for nlp, ml, automl and mlnotebooks
RUN . /opt/conda/etc/profile.d/conda.sh \
	&& conda activate kx \ 
	&& conda install --file /opt/kx/nlp/requirements.txt \ 
	&& pip install -r /opt/kx/mlnotebooks/requirements.txt \
	&& conda install -c anaconda graphviz \
        && pip install pip==9.0.1 \
        && pip install -r /opt/kx/ml/requirements.txt \
	&& conda install -c conda-forge --file /opt/kx/automl/requirements.txt \
	&& conda clean -y --all \
	&& python -m spacy download en \
	&& cd /opt/kx/jupyterq/jupyterq_licensemgr \
	&& python setup.py build \
	&& pip install --user --no-deps .

USER root

ARG nbroot=/opt/kx/mlnotebooks/notebooks
ARG nbdata=/opt/kx/mlnotebooks/data
ARG nbscripts=/opt/kx/mlnotebooks/notebooks

ENV NBROOT=${nbroot}
ENV NBDATA=${nbdata}
ENV NBSCRIPTS=${nbscipts}

ENTRYPOINT ["/init"]
