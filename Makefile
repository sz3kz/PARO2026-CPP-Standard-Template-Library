.PHONY: run build init clean

BUILD_DIRECTORY=build/
TASK1=unique
TASK2=cheap
TASK3=pow2
OUTPUT_FILENAME=.output.gz

package:
	-rm ${OUTPUT_FILENAME}
	head -n -0 *.cpp | gzip > ${OUTPUT_FILENAME}

run:
	./${BUILD_DIRECTORY}${TASK1}
	./${BUILD_DIRECTORY}${TASK2}
	./${BUILD_DIRECTORY}${TASK3}

build:
	cd ${BUILD_DIRECTORY} && make

init: clean
	mkdir ${BUILD_DIRECTORY}
	cd ${BUILD_DIRECTORY} && cmake .. -DCMAKE_POLICY_VERSION_MINIMUM=3.5

clean:
	rm -rf ${BUILD_DIRECTORY}
