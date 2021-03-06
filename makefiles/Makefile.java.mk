# Main target
java: javaortools

# Clean target
clean_java:
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)jni*.$(JNI_LIB_EXT)
	-$(DEL) $(LIB_DIR)$S*.jar
	-$(DEL) $(GEN_DIR)$Scom$Sgoogle$Sortools$Sconstraintsolver$S*.java
	-$(DEL) $(GEN_DIR)$Scom$Sgoogle$Sortools$Sgraph$S*.java
	-$(DEL) $(GEN_DIR)$Scom$Sgoogle$Sortools$Salgorithms$S*.java
	-$(DEL) $(GEN_DIR)$Scom$Sgoogle$Sortools$Slinearsolver$S*.java
	-$(DEL) $(GEN_DIR)$Salgorithms$S*java_wrap*
	-$(DEL) $(GEN_DIR)$Sconstraint_solver$S*java_wrap*
	-$(DEL) $(GEN_DIR)$Sgraph$S*java_wrap*
	-$(DEL) $(GEN_DIR)$Slinear_solver$S*java_wrap*
	-$(DEL) $(OBJ_DIR)$Scom$Sgoogle$Sortools$Sconstraintsolver$S*.class
	-$(DEL) $(OBJ_DIR)$Scom$Sgoogle$Sortools$Sgraph$S*.class
	-$(DEL) $(OBJ_DIR)$Scom$Sgoogle$Sortools$Salgorithms$S*.class
	-$(DEL) $(OBJ_DIR)$Scom$Sgoogle$Sortools$Slinearsolver$S*.class
	-$(DEL) $(OBJ_DIR)$Scom$Sgoogle$Sortools$Ssamples$S*.class
	-$(DEL) $(OBJ_DIR)$Sswig$S*java_wrap.$O

# ---------- Java support using SWIG ----------

# javaortools

javaortools: $(LIB_DIR)/com.google.ortools.jar $(LIB_DIR)/$(LIBPREFIX)jniortools.$(JNI_LIB_EXT)

$(GEN_DIR)/constraint_solver/constraint_solver_java_wrap.cc: $(SRC_DIR)/constraint_solver/java/constraint_solver.swig $(SRC_DIR)/constraint_solver/java/routing.swig $(SRC_DIR)/base/base.swig $(SRC_DIR)/util/java/vector.swig $(SRC_DIR)/base/base.swig $(SRC_DIR)/util/java/proto.swig $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(SWIG_BINARY) -I$(INC_DIR) -c++ -java -o $(GEN_DIR)$Sconstraint_solver$Sconstraint_solver_java_wrap.cc -package com.google.ortools.constraintsolver -module operations_research_constraint_solver -outdir $(GEN_DIR)$Scom$Sgoogle$Sortools$Sconstraintsolver $(SRC_DIR)$Sconstraint_solver$Sjava$Srouting.swig

$(OBJ_DIR)/swig/constraint_solver_java_wrap.$O: $(GEN_DIR)/constraint_solver/constraint_solver_java_wrap.cc
	$(CCC) $(JNIFLAGS) $(JAVA_INC) -c $(GEN_DIR)$Sconstraint_solver$Sconstraint_solver_java_wrap.cc $(OBJ_OUT)$(OBJ_DIR)$Sswig$Sconstraint_solver_java_wrap.$O

$(GEN_DIR)/algorithms/knapsack_solver_java_wrap.cc: $(SRC_DIR)/algorithms/java/knapsack_solver.swig $(SRC_DIR)/base/base.swig $(SRC_DIR)/util/java/vector.swig $(SRC_DIR)/algorithms/knapsack_solver.h
	$(SWIG_BINARY) -I$(INC_DIR) -c++ -java -o $(GEN_DIR)$Salgorithms$Sknapsack_solver_java_wrap.cc -package com.google.ortools.algorithms -module operations_research_algorithms -outdir $(GEN_DIR)$Scom$Sgoogle$Sortools$Salgorithms $(SRC_DIR)$Salgorithms$Sjava$Sknapsack_solver.swig

$(OBJ_DIR)/swig/knapsack_solver_java_wrap.$O: $(GEN_DIR)/algorithms/knapsack_solver_java_wrap.cc
	$(CCC) $(JNIFLAGS) $(JAVA_INC) -c $(GEN_DIR)$Salgorithms$Sknapsack_solver_java_wrap.cc $(OBJ_OUT)$(OBJ_DIR)$Sswig$Sknapsack_solver_java_wrap.$O

$(GEN_DIR)/graph/graph_java_wrap.cc: $(SRC_DIR)/graph/java/graph.swig $(SRC_DIR)/base/base.swig $(SRC_DIR)/graph/max_flow.h $(SRC_DIR)/graph/min_cost_flow.h $(SRC_DIR)/graph/linear_assignment.h
	$(SWIG_BINARY) -I$(INC_DIR) -c++ -java -o $(GEN_DIR)$Sgraph$Sgraph_java_wrap.cc -package com.google.ortools.graph -module operations_research_graph -outdir $(GEN_DIR)$Scom$Sgoogle$Sortools$Sgraph $(SRC_DIR)$Sgraph$Sjava$Sgraph.swig

$(GEN_DIR)/linear_solver/linear_solver_java_wrap.cc: $(SRC_DIR)/linear_solver/java/linear_solver.swig $(SRC_DIR)/base/base.swig $(SRC_DIR)/util/java/vector.swig $(SRC_DIR)/linear_solver/linear_solver.h $(GEN_DIR)/linear_solver/linear_solver.pb.h
	$(SWIG_BINARY) $(SWIG_INC) -I$(INC_DIR) -c++ -java -o $(GEN_DIR)$Slinear_solver$Slinear_solver_java_wrap.cc -package com.google.ortools.linearsolver -module operations_research_linear_solver -outdir $(GEN_DIR)$Scom$Sgoogle$Sortools$Slinearsolver $(SRC_DIR)$Slinear_solver$Sjava$Slinear_solver.swig

$(OBJ_DIR)/swig/linear_solver_java_wrap.$O: $(GEN_DIR)/linear_solver/linear_solver_java_wrap.cc
	$(CCC) $(JNIFLAGS) $(JAVA_INC) -c $(GEN_DIR)$Slinear_solver$Slinear_solver_java_wrap.cc $(OBJ_OUT)$(OBJ_DIR)$Sswig$Slinear_solver_java_wrap.$O

$(OBJ_DIR)/swig/graph_java_wrap.$O: $(GEN_DIR)/graph/graph_java_wrap.cc
	$(CCC) $(JNIFLAGS) $(JAVA_INC) -c $(GEN_DIR)$Sgraph$Sgraph_java_wrap.cc $(OBJ_OUT)$(OBJ_DIR)$Sswig$Sgraph_java_wrap.$O

$(GEN_DIR)/com/google/ortools/constraintsolver/SearchLimitProtobuf.java: $(SRC_DIR)/constraint_solver/search_limit.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(SRC_DIR) --java_out=$(GEN_DIR) $(SRC_DIR)$Sconstraint_solver$Ssearch_limit.proto

$(GEN_DIR)/com/google/ortools/constraintsolver/SolverParameters.java: $(SRC_DIR)/constraint_solver/solver_parameters.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(SRC_DIR) --java_out=$(GEN_DIR) $(SRC_DIR)$Sconstraint_solver$Ssolver_parameters.proto

$(GEN_DIR)/com/google/ortools/constraintsolver/RoutingParameters.java: $(SRC_DIR)/constraint_solver/routing_parameters.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(SRC_DIR) --java_out=$(GEN_DIR) $(SRC_DIR)$Sconstraint_solver$Srouting_parameters.proto

$(GEN_DIR)/com/google/ortools/constraintsolver/RoutingEnums.java: $(SRC_DIR)/constraint_solver/routing_enums.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(SRC_DIR) --java_out=$(GEN_DIR) $(SRC_DIR)$Sconstraint_solver$Srouting_enums.proto

$(LIB_DIR)/protobuf.jar: dependencies/install/lib/protobuf.jar
	$(COPY) dependencies$Sinstall$Slib$Sprotobuf.jar $(LIB_DIR)

$(LIB_DIR)/com.google.ortools.jar: \
	$(LIB_DIR)/protobuf.jar \
	$(GEN_DIR)/constraint_solver/constraint_solver_java_wrap.cc \
	$(GEN_DIR)/algorithms/knapsack_solver_java_wrap.cc \
	$(GEN_DIR)/graph/graph_java_wrap.cc \
	$(GEN_DIR)/linear_solver/linear_solver_java_wrap.cc \
	$(GEN_DIR)/com/google/ortools/constraintsolver/SolverParameters.java \
	$(GEN_DIR)/com/google/ortools/constraintsolver/SearchLimitProtobuf.java \
	$(GEN_DIR)/com/google/ortools/constraintsolver/RoutingParameters.java \
	$(GEN_DIR)/com/google/ortools/constraintsolver/RoutingEnums.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp lib$Sprotobuf.jar $(SRC_DIR)$Scom$Sgoogle$Sortools$Sconstraintsolver$S*.java $(GEN_DIR)$Scom$Sgoogle$Sortools$Sconstraintsolver$S*.java $(GEN_DIR)$Scom$Sgoogle$Sortools$Salgorithms$S*.java $(GEN_DIR)$Scom$Sgoogle$Sortools$Sgraph$S*.java $(GEN_DIR)$Scom$Sgoogle$Sortools$Slinearsolver$S*.java
	$(JAR_BIN) cf $(LIB_DIR)$Scom.google.ortools.jar -C $(OBJ_DIR) com$Sgoogle$Sortools$S

$(LIB_DIR)/$(LIBPREFIX)jniortools.$(JNI_LIB_EXT): \
	$(OBJ_DIR)/swig/constraint_solver_java_wrap.$O \
	$(OBJ_DIR)/swig/knapsack_solver_java_wrap.$O \
	$(OBJ_DIR)/swig/graph_java_wrap.$O \
	$(OBJ_DIR)/swig/linear_solver_java_wrap.$O \
	$(STATIC_ALL_DEPS)
	$(DYNAMIC_LD) $(LDOUT)$(LIB_DIR)$S$(LIBPREFIX)jniortools.$(JNI_LIB_EXT) $(OBJ_DIR)$Sswig$Sconstraint_solver_java_wrap.$O $(OBJ_DIR)/swig/knapsack_solver_java_wrap.$O $(OBJ_DIR)/swig/graph_java_wrap.$O $(OBJ_DIR)/swig/linear_solver_java_wrap.$O $(STATIC_ALL_LNK) $(STATIC_LD_FLAGS)

# Java CP Examples

compile_RabbitsPheasants: $(OBJ_DIR)/com/google/ortools/samples/RabbitsPheasants.class

$(OBJ_DIR)/com/google/ortools/samples/RabbitsPheasants.class: javaortools $(EX_DIR)/com/google/ortools/samples/RabbitsPheasants.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SRabbitsPheasants.java

run_RabbitsPheasants: compile_RabbitsPheasants
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.RabbitsPheasants

compile_LsApi: $(OBJ_DIR)/com/google/ortools/samples/LsApi.class

$(OBJ_DIR)/com/google/ortools/samples/LsApi.class: javaortools $(EX_DIR)/com/google/ortools/samples/LsApi.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SLsApi.java

run_LsApi: compile_LsApi
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.LsApi

compile_GolombRuler: $(OBJ_DIR)/com/google/ortools/samples/GolombRuler.class

$(OBJ_DIR)/com/google/ortools/samples/GolombRuler.class: javaortools $(EX_DIR)/com/google/ortools/samples/GolombRuler.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SGolombRuler.java

run_GolombRuler: compile_GolombRuler
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.GolombRuler

compile_Partition: $(OBJ_DIR)/com/google/ortools/samples/Partition.class

$(OBJ_DIR)/com/google/ortools/samples/Partition.class: javaortools $(EX_DIR)/com/google/ortools/samples/Partition.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SPartition.java

run_Partition: compile_Partition
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Partition

compile_SendMoreMoney: $(OBJ_DIR)/com/google/ortools/samples/SendMoreMoney.class

$(OBJ_DIR)/com/google/ortools/samples/SendMoreMoney.class: javaortools $(EX_DIR)/com/google/ortools/samples/SendMoreMoney.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SSendMoreMoney.java

run_SendMoreMoney: compile_SendMoreMoney
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.SendMoreMoney

compile_SendMoreMoney2: $(OBJ_DIR)/com/google/ortools/samples/SendMoreMoney2.class

$(OBJ_DIR)/com/google/ortools/samples/SendMoreMoney2.class: javaortools $(EX_DIR)/com/google/ortools/samples/SendMoreMoney2.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SSendMoreMoney2.java

run_SendMoreMoney2: compile_SendMoreMoney2
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.SendMoreMoney2

compile_LeastDiff: $(OBJ_DIR)/com/google/ortools/samples/LeastDiff.class

$(OBJ_DIR)/com/google/ortools/samples/LeastDiff.class: javaortools $(EX_DIR)/com/google/ortools/samples/LeastDiff.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SLeastDiff.java

run_LeastDiff: compile_LeastDiff
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.LeastDiff

compile_MagicSquare: $(OBJ_DIR)/com/google/ortools/samples/MagicSquare.class

$(OBJ_DIR)/com/google/ortools/samples/MagicSquare.class: javaortools $(EX_DIR)/com/google/ortools/samples/MagicSquare.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SMagicSquare.java

run_MagicSquare: compile_MagicSquare
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.MagicSquare

compile_NQueens: $(OBJ_DIR)/com/google/ortools/samples/NQueens.class

$(OBJ_DIR)/com/google/ortools/samples/NQueens.class: javaortools $(EX_DIR)/com/google/ortools/samples/NQueens.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SNQueens.java

run_NQueens: compile_NQueens
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.NQueens

compile_NQueens2: $(OBJ_DIR)/com/google/ortools/samples/NQueens2.class

$(OBJ_DIR)/com/google/ortools/samples/NQueens2.class: javaortools $(EX_DIR)/com/google/ortools/samples/NQueens2.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SNQueens2.java

run_NQueens2: compile_NQueens2
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.NQueens2


compile_AllDifferentExcept0: $(OBJ_DIR)/com/google/ortools/samples/AllDifferentExcept0.class

$(OBJ_DIR)/com/google/ortools/samples/AllDifferentExcept0.class: javaortools $(EX_DIR)/com/google/ortools/samples/AllDifferentExcept0.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SAllDifferentExcept0.java

run_AllDifferentExcept0: compile_AllDifferentExcept0
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.AllDifferentExcept0


compile_Diet: $(OBJ_DIR)/com/google/ortools/samples/Diet.class

$(OBJ_DIR)/com/google/ortools/samples/Diet.class: javaortools $(EX_DIR)/com/google/ortools/samples/Diet.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SDiet.java

run_Diet: compile_Diet
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Diet


compile_Map: $(OBJ_DIR)/com/google/ortools/samples/Map.class

$(OBJ_DIR)/com/google/ortools/samples/Map.class: javaortools $(EX_DIR)/com/google/ortools/samples/Map.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SMap.java

run_Map: compile_Map
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Map


compile_Map2: $(OBJ_DIR)/com/google/ortools/samples/Map2.class

$(OBJ_DIR)/com/google/ortools/samples/Map2.class: javaortools $(EX_DIR)/com/google/ortools/samples/Map2.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SMap2.java

run_Map2: compile_Map2
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Map2


compile_Minesweeper: $(OBJ_DIR)/com/google/ortools/samples/Minesweeper.class

$(OBJ_DIR)/com/google/ortools/samples/Minesweeper.class: javaortools $(EX_DIR)/com/google/ortools/samples/Minesweeper.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SMinesweeper.java

run_Minesweeper: compile_Minesweeper
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Minesweeper


compile_QuasigroupCompletion: $(OBJ_DIR)/com/google/ortools/samples/QuasigroupCompletion.class

$(OBJ_DIR)/com/google/ortools/samples/QuasigroupCompletion.class: javaortools $(EX_DIR)/com/google/ortools/samples/QuasigroupCompletion.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SQuasigroupCompletion.java

run_QuasigroupCompletion: compile_QuasigroupCompletion
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.QuasigroupCompletion


compile_SendMostMoney: $(OBJ_DIR)/com/google/ortools/samples/SendMostMoney.class

$(OBJ_DIR)/com/google/ortools/samples/SendMostMoney.class: javaortools $(EX_DIR)/com/google/ortools/samples/SendMostMoney.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SSendMostMoney.java

run_SendMostMoney: compile_SendMostMoney
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.SendMostMoney


compile_Seseman: $(OBJ_DIR)/com/google/ortools/samples/Seseman.class

$(OBJ_DIR)/com/google/ortools/samples/Seseman.class: javaortools $(EX_DIR)/com/google/ortools/samples/Seseman.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SSeseman.java

run_Seseman: compile_Seseman
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Seseman


compile_Sudoku: $(OBJ_DIR)/com/google/ortools/samples/Sudoku.class

$(OBJ_DIR)/com/google/ortools/samples/Sudoku.class: javaortools $(EX_DIR)/com/google/ortools/samples/Sudoku.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SSudoku.java

run_Sudoku: compile_Sudoku
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Sudoku

compile_Tsp: $(OBJ_DIR)/com/google/ortools/samples/Tsp.class

$(OBJ_DIR)/com/google/ortools/samples/Tsp.class: javaortools $(EX_DIR)/com/google/ortools/samples/Tsp.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$STsp.java

run_Tsp: compile_Tsp
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Tsp $(ARGS)

compile_CapacitatedVehicleRoutingProblemWithTimeWindows: $(OBJ_DIR)/com/google/ortools/samples/CapacitatedVehicleRoutingProblemWithTimeWindows.class

$(OBJ_DIR)/com/google/ortools/samples/CapacitatedVehicleRoutingProblemWithTimeWindows.class: javaortools $(EX_DIR)/com/google/ortools/samples/CapacitatedVehicleRoutingProblemWithTimeWindows.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SCapacitatedVehicleRoutingProblemWithTimeWindows.java

run_CapacitatedVehicleRoutingProblemWithTimeWindows: compile_CapacitatedVehicleRoutingProblemWithTimeWindows
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.CapacitatedVehicleRoutingProblemWithTimeWindows $(ARGS)

compile_Xkcd: $(OBJ_DIR)/com/google/ortools/samples/Xkcd.class

$(OBJ_DIR)/com/google/ortools/samples/Xkcd.class: javaortools $(EX_DIR)/com/google/ortools/samples/Xkcd.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SXkcd.java

run_Xkcd: compile_Xkcd
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Xkcd


compile_SurvoPuzzle: $(OBJ_DIR)/com/google/ortools/samples/SurvoPuzzle.class

$(OBJ_DIR)/com/google/ortools/samples/SurvoPuzzle.class: javaortools $(EX_DIR)/com/google/ortools/samples/SurvoPuzzle.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SSurvoPuzzle.java

run_SurvoPuzzle: compile_SurvoPuzzle
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.SurvoPuzzle


compile_Circuit: $(OBJ_DIR)/com/google/ortools/samples/Circuit.class

$(OBJ_DIR)/com/google/ortools/samples/Circuit.class: javaortools $(EX_DIR)/com/google/ortools/samples/Circuit.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SCircuit.java

run_Circuit: compile_Circuit
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Circuit


compile_CoinsGrid: $(OBJ_DIR)/com/google/ortools/samples/CoinsGrid.class

$(OBJ_DIR)/com/google/ortools/samples/CoinsGrid.class: javaortools $(EX_DIR)/com/google/ortools/samples/CoinsGrid.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SCoinsGrid.java

run_CoinsGrid: compile_CoinsGrid
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.CoinsGrid

# Java Algorithms Examples

compile_Knapsack: $(OBJ_DIR)/com/google/ortools/samples/Knapsack.class

$(OBJ_DIR)/com/google/ortools/samples/Knapsack.class: javaortools $(EX_DIR)/com/google/ortools/samples/Knapsack.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SKnapsack.java

run_Knapsack: compile_Knapsack
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Knapsack

# Java Algorithms Examples

compile_FlowExample: $(OBJ_DIR)/com/google/ortools/samples/FlowExample.class

$(OBJ_DIR)/com/google/ortools/samples/FlowExample.class: javaortools $(EX_DIR)/com/google/ortools/samples/FlowExample.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SFlowExample.java

run_FlowExample: compile_FlowExample javaortools
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.FlowExample

compile_LinearAssignmentAPI: $(OBJ_DIR)/com/google/ortools/samples/LinearAssignmentAPI.class

$(OBJ_DIR)/com/google/ortools/samples/LinearAssignmentAPI.class: javaortools $(EX_DIR)/com/google/ortools/samples/LinearAssignmentAPI.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)com$Sgoogle$Sortools$Ssamples$SLinearAssignmentAPI.java

run_LinearAssignmentAPI: compile_LinearAssignmentAPI javaortools
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.LinearAssignmentAPI

# Java Linear Programming Examples

compile_LinearProgramming: $(OBJ_DIR)/com/google/ortools/samples/LinearProgramming.class

$(OBJ_DIR)/com/google/ortools/samples/LinearProgramming.class: javaortools $(EX_DIR)/com/google/ortools/samples/LinearProgramming.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SLinearProgramming.java

run_LinearProgramming: compile_LinearProgramming
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.LinearProgramming

compile_IntegerProgramming: $(OBJ_DIR)/com/google/ortools/samples/IntegerProgramming.class

$(OBJ_DIR)/com/google/ortools/samples/IntegerProgramming.class: javaortools $(EX_DIR)/com/google/ortools/samples/IntegerProgramming.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SIntegerProgramming.java

run_IntegerProgramming: compile_IntegerProgramming
	$(JAVA_BIN) -Xss2048k -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.IntegerProgramming

compile_Issue173: $(OBJ_DIR)/com/google/ortools/samples/Issue173.class

$(OBJ_DIR)/com/google/ortools/samples/Issue173.class: javaortools $(EX_DIR)/com/google/ortools/samples/Issue173.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SIssue173.java

run_Issue173: compile_Issue173
	$(JAVA_BIN) -Xss2048k -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.Issue173


# Integer programming Coin-CBC section
run_MultiThreadIntegerProgramming: compile_MultiThreadIntegerProgramming
	$(JAVA_BIN) -Xss2048k -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.MultiThreadTest

compile_MultiThreadIntegerProgramming: $(OBJ_DIR)/com/google/ortools/samples/MultiThreadTest.class

$(OBJ_DIR)/com/google/ortools/samples/MultiThreadTest.class: javaortools $(EX_DIR)/com/google/ortools/samples/MultiThreadTest.java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$SMultiThreadTest.java



# Compile and Run CP java example:

$(OBJ_DIR)/com/google/ortools/samples/$(EX).class: javaortools $(EX_DIR)/com/google/ortools/samples/$(EX).java
	$(JAVAC_BIN) -d $(OBJ_DIR) -cp $(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar $(EX_DIR)$Scom$Sgoogle$Sortools$Ssamples$S$(EX).java

cjava: $(OBJ_DIR)/com/google/ortools/samples/$(EX).class

rjava: $(OBJ_DIR)/com/google/ortools/samples/$(EX).class javaortools
	$(JAVA_BIN) -Djava.library.path=$(LIB_DIR) -cp $(OBJ_DIR)$(CPSEP)$(LIB_DIR)$Scom.google.ortools.jar$(CPSEP)$(LIB_DIR)$Sprotobuf.jar com.google.ortools.samples.$(EX) $(ARGS)

# Build stand-alone archive file for redistribution.

java_archive: java
	-$(DELREC) temp
	$(MKDIR) temp
	$(MKDIR) temp$Sor-tools.$(PORT)
	$(MKDIR) temp$Sor-tools.$(PORT)$Slib
	$(MKDIR) temp$Sor-tools.$(PORT)$Sobjs
	$(COPY) LICENSE-2.0.txt temp$Sor-tools.$(PORT)
	$(COPY) tools$SREADME.java temp$Sor-tools.$(PORT)$SREADME
	$(COPY) lib$S*.jar temp$Sor-tools.$(PORT)$Slib
	$(COPY) lib$S$(LIBPREFIX)jni*.$(JNI_LIB_EXT) temp$Sor-tools.$(PORT)$Slib
ifeq ("$(SYSTEM)","win")
	tools\mkdir temp\or-tools.$(PORT)\examples
	tools\mkdir temp\or-tools.$(PORT)\examples\com
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google\ortools
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google\ortools\algorithms
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google\ortools\constraintsolver
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google\ortools\graph
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google\ortools\linearsolver
	tools\mkdir temp\or-tools.$(PORT)\examples\com\google\ortools\samples
	tools\mkdir temp\or-tools.$(PORT)\examples\data
	tools\mkdir temp\or-tools.$(PORT)\examples\data\discrete_tomography
	tools\mkdir temp\or-tools.$(PORT)\examples\data\fill_a_pix
	tools\mkdir temp\or-tools.$(PORT)\examples\data\minesweeper
	tools\mkdir temp\or-tools.$(PORT)\examples\data\rogo
	tools\mkdir temp\or-tools.$(PORT)\examples\data\survo_puzzle
	tools\mkdir temp\or-tools.$(PORT)\examples\data\quasigroup_completion
	copy examples\data\discrete_tomography\* temp\or-tools.$(PORT)\examples\data\discrete_tomography
	copy examples\data\fill_a_pix\* temp\or-tools.$(PORT)\examples\data\fill_a_pix
	copy examples\data\minesweeper\* temp\or-tools.$(PORT)\examples\data\minesweeper
	copy examples\data\rogo\* temp\or-tools.$(PORT)\examples\data\rogo
	copy examples\data\survo_puzzle\* temp\or-tools.$(PORT)\examples\data\survo_puzzle
	copy examples\data\quasigroup_completion\* temp\or-tools.$(PORT)\examples\data\quasigroup_completion
	copy examples\com\google\ortools\samples\*.java temp\or-tools.$(PORT)\examples\com\google\ortools\samples
	copy examples\com\google\ortools\samples\*.java temp\or-tools.$(PORT)\examples\com\google\ortools\samples
	copy examples\com\google\ortools\samples\*.java temp\or-tools.$(PORT)\examples\com\google\ortools\samples
	copy examples\com\google\ortools\samples\*.java temp\or-tools.$(PORT)\examples\com\google\ortools\samples
	cd temp && ..$Stools$Szip.exe -r ..$SGoogle.OrTools.java.$(PORT).$(GIT_REVISION).zip or-tools.$(PORT)
else
	mkdir temp/or-tools.$(PORT)/examples
	mkdir temp/or-tools.$(PORT)/examples/com
	mkdir temp/or-tools.$(PORT)/examples/com/google
	mkdir temp/or-tools.$(PORT)/examples/com/google/ortools
	mkdir temp/or-tools.$(PORT)/examples/com/google/ortools/algorithms
	mkdir temp/or-tools.$(PORT)/examples/com/google/ortools/constraintsolver
	mkdir temp/or-tools.$(PORT)/examples/com/google/ortools/graph
	mkdir temp/or-tools.$(PORT)/examples/com/google/ortools/linearsolver
	mkdir temp/or-tools.$(PORT)/examples/com/google/ortools/samples
	mkdir temp/or-tools.$(PORT)/examples/data
	mkdir temp/or-tools.$(PORT)/examples/data/discrete_tomography
	mkdir temp/or-tools.$(PORT)/examples/data/fill_a_pix
	mkdir temp/or-tools.$(PORT)/examples/data/minesweeper
	mkdir temp/or-tools.$(PORT)/examples/data/rogo
	mkdir temp/or-tools.$(PORT)/examples/data/survo_puzzle
	mkdir temp/or-tools.$(PORT)/examples/data/quasigroup_completion
	cp examples/data/discrete_tomography/* temp/or-tools.$(PORT)/examples/data/discrete_tomography
	cp examples/data/fill_a_pix/* temp/or-tools.$(PORT)/examples/data/fill_a_pix
	cp examples/data/minesweeper/* temp/or-tools.$(PORT)/examples/data/minesweeper
	cp examples/data/rogo/* temp/or-tools.$(PORT)/examples/data/rogo
	cp examples/data/survo_puzzle/* temp/or-tools.$(PORT)/examples/data/survo_puzzle
	cp examples/data/quasigroup_completion/* temp/or-tools.$(PORT)/examples/data/quasigroup_completion
	cp examples/com/google/ortools/samples/*.java temp/or-tools.$(PORT)/examples/com/google/ortools/samples
	cp examples/com/google/ortools/samples/*.java temp/or-tools.$(PORT)/examples/com/google/ortools/samples
	cp examples/com/google/ortools/samples/*.java temp/or-tools.$(PORT)/examples/com/google/ortools/samples
	cp examples/com/google/ortools/samples/*.java temp/or-tools.$(PORT)/examples/com/google/ortools/samples
	cp examples/com/google/ortools/samples/*.java temp/or-tools.$(PORT)/examples/com/google/ortools/samples
	cd temp && tar -c -v -z --no-same-owner -f ../Google.OrTools.java.$(PORT).$(GIT_REVISION).tar.gz or-tools.$(PORT)
endif
	-$(DELREC) temp
