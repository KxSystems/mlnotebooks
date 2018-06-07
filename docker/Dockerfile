# ARG usage in FROMs has to go up here in global

ARG jupyterq_img=kxsys/jupyterq:latest
ARG nlp_img=kxsys/nlp:latest

####
FROM $nlp_img AS nlp
FROM $jupyterq_img AS jupyterq

FROM jupyterq AS mlnotebooks

COPY requirements.txt README.md /opt/kx/mlnotebooks/
COPY data/ /opt/kx/mlnotebooks/data/
COPY images/ /opt/kx/mlnotebooks/images/
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
# jupyterq is the base, install requirements for nlp and mlnotebooks
RUN . /opt/conda/etc/profile.d/conda.sh \
	&& conda activate kx \
	&& conda install --file /opt/kx/nlp/requirements.txt \
	&& pip install -r /opt/kx/mlnotebooks/requirements.txt \
	&& conda install -c anaconda graphviz \
	&& conda clean -y --all \
	&& python -m spacy download en

USER root

ENTRYPOINT ["/init"]
CMD ["/bin/sh", "-l", "-c", "printf '\npoint your browser at http://127.0.0.1:%s/tree/notebooks/\n\n' $PORT && exec jupyter notebook --notebook-dir=/opt/kx/mlnotebooks --ip='0.0.0.0' --port=$PORT --no-browser"]
