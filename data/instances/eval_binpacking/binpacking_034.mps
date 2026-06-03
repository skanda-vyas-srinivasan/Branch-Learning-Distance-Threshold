* SCIP STATISTICS
*   Problem name     : model
*   Variables        : 312 (312 binary, 0 integer, 0 implicit integer, 0 continuous)
*   Constraints      : 48
NAME          model
OBJSENSE
  MIN
ROWS
 N  Obj 
 E  assign_0 
 E  assign_1 
 E  assign_2 
 E  assign_3 
 E  assign_4 
 E  assign_5 
 E  assign_6 
 E  assign_7 
 E  assign_8 
 E  assign_9 
 E  assign_10 
 E  assign_11 
 E  assign_12 
 E  assign_13 
 E  assign_14 
 E  assign_15 
 E  assign_16 
 E  assign_17 
 E  assign_18 
 E  assign_19 
 E  assign_20 
 E  assign_21 
 E  assign_22 
 E  assign_23 
 E  assign_24 
 L  capacity_0 
 L  capacity_1 
 L  capacity_2 
 L  capacity_3 
 L  capacity_4 
 L  capacity_5 
 L  capacity_6 
 L  capacity_7 
 L  capacity_8 
 L  capacity_9 
 L  capacity_10 
 L  capacity_11 
 G  symmetry_0 
 G  symmetry_1 
 G  symmetry_2 
 G  symmetry_3 
 G  symmetry_4 
 G  symmetry_5 
 G  symmetry_6 
 G  symmetry_7 
 G  symmetry_8 
 G  symmetry_9 
 G  symmetry_10 
COLUMNS
    INTSTART     'MARKER'                               'INTORG'                              
    y_0          Obj                                 1  capacity_0                        -56 
    y_0          symmetry_0                          1 
    y_1          Obj                                 1  capacity_1                        -56 
    y_1          symmetry_0                         -1  symmetry_1                          1 
    y_2          Obj                                 1  capacity_2                        -56 
    y_2          symmetry_1                         -1  symmetry_2                          1 
    y_3          Obj                                 1  symmetry_2                         -1 
    y_3          symmetry_3                          1  capacity_3                        -56 
    y_4          symmetry_3                         -1  capacity_4                        -56 
    y_4          Obj                                 1  symmetry_4                          1 
    y_5          capacity_5                        -56  Obj                                 1 
    y_5          symmetry_4                         -1  symmetry_5                          1 
    y_6          symmetry_6                          1  symmetry_5                         -1 
    y_6          Obj                                 1  capacity_6                        -56 
    y_7          Obj                                 1  symmetry_6                         -1 
    y_7          symmetry_7                          1  capacity_7                        -56 
    y_8          symmetry_7                         -1  symmetry_8                          1 
    y_8          capacity_8                        -56  Obj                                 1 
    y_9          capacity_9                        -56  symmetry_8                         -1 
    y_9          Obj                                 1  symmetry_9                          1 
    y_10         symmetry_9                         -1  symmetry_10                         1 
    y_10         Obj                                 1  capacity_10                       -56 
    y_11         capacity_11                       -56  symmetry_10                        -1 
    y_11         Obj                                 1 
    x_0_0        assign_0                            1  capacity_0                         19 
    x_0_0        Obj                                 0 
    x_0_1        assign_0                            1  Obj                                 0 
    x_0_1        capacity_1                         19 
    x_0_2        capacity_2                         19  assign_0                            1 
    x_0_2        Obj                                 0 
    x_0_3        Obj                                 0  assign_0                            1 
    x_0_3        capacity_3                         19 
    x_0_4        Obj                                 0  capacity_4                         19 
    x_0_4        assign_0                            1 
    x_0_5        assign_0                            1  capacity_5                         19 
    x_0_5        Obj                                 0 
    x_0_6        assign_0                            1  Obj                                 0 
    x_0_6        capacity_6                         19 
    x_0_7        assign_0                            1  Obj                                 0 
    x_0_7        capacity_7                         19 
    x_0_8        capacity_8                         19  assign_0                            1 
    x_0_8        Obj                                 0 
    x_0_9        capacity_9                         19  assign_0                            1 
    x_0_9        Obj                                 0 
    x_0_10       Obj                                 0  assign_0                            1 
    x_0_10       capacity_10                        19 
    x_0_11       assign_0                            1  capacity_11                        19 
    x_0_11       Obj                                 0 
    x_1_0        Obj                                 0  capacity_0                         28 
    x_1_0        assign_1                            1 
    x_1_1        capacity_1                         28  Obj                                 0 
    x_1_1        assign_1                            1 
    x_1_2        assign_1                            1  Obj                                 0 
    x_1_2        capacity_2                         28 
    x_1_3        Obj                                 0  assign_1                            1 
    x_1_3        capacity_3                         28 
    x_1_4        Obj                                 0  capacity_4                         28 
    x_1_4        assign_1                            1 
    x_1_5        Obj                                 0  capacity_5                         28 
    x_1_5        assign_1                            1 
    x_1_6        Obj                                 0  capacity_6                         28 
    x_1_6        assign_1                            1 
    x_1_7        capacity_7                         28  assign_1                            1 
    x_1_7        Obj                                 0 
    x_1_8        capacity_8                         28  assign_1                            1 
    x_1_8        Obj                                 0 
    x_1_9        capacity_9                         28  assign_1                            1 
    x_1_9        Obj                                 0 
    x_1_10       capacity_10                        28  assign_1                            1 
    x_1_10       Obj                                 0 
    x_1_11       Obj                                 0  assign_1                            1 
    x_1_11       capacity_11                        28 
    x_2_0        capacity_0                         19  assign_2                            1 
    x_2_0        Obj                                 0 
    x_2_1        Obj                                 0  capacity_1                         19 
    x_2_1        assign_2                            1 
    x_2_2        Obj                                 0  assign_2                            1 
    x_2_2        capacity_2                         19 
    x_2_3        assign_2                            1  capacity_3                         19 
    x_2_3        Obj                                 0 
    x_2_4        Obj                                 0  capacity_4                         19 
    x_2_4        assign_2                            1 
    x_2_5        assign_2                            1  capacity_5                         19 
    x_2_5        Obj                                 0 
    x_2_6        assign_2                            1  capacity_6                         19 
    x_2_6        Obj                                 0 
    x_2_7        Obj                                 0  assign_2                            1 
    x_2_7        capacity_7                         19 
    x_2_8        assign_2                            1  Obj                                 0 
    x_2_8        capacity_8                         19 
    x_2_9        Obj                                 0  capacity_9                         19 
    x_2_9        assign_2                            1 
    x_2_10       capacity_10                        19  assign_2                            1 
    x_2_10       Obj                                 0 
    x_2_11       assign_2                            1  Obj                                 0 
    x_2_11       capacity_11                        19 
    x_3_0        Obj                                 0  capacity_0                         17 
    x_3_0        assign_3                            1 
    x_3_1        capacity_1                         17  assign_3                            1 
    x_3_1        Obj                                 0 
    x_3_2        assign_3                            1  Obj                                 0 
    x_3_2        capacity_2                         17 
    x_3_3        capacity_3                         17  Obj                                 0 
    x_3_3        assign_3                            1 
    x_3_4        Obj                                 0  assign_3                            1 
    x_3_4        capacity_4                         17 
    x_3_5        capacity_5                         17  Obj                                 0 
    x_3_5        assign_3                            1 
    x_3_6        assign_3                            1  Obj                                 0 
    x_3_6        capacity_6                         17 
    x_3_7        assign_3                            1  Obj                                 0 
    x_3_7        capacity_7                         17 
    x_3_8        capacity_8                         17  Obj                                 0 
    x_3_8        assign_3                            1 
    x_3_9        assign_3                            1  Obj                                 0 
    x_3_9        capacity_9                         17 
    x_3_10       capacity_10                        17  assign_3                            1 
    x_3_10       Obj                                 0 
    x_3_11       capacity_11                        17  assign_3                            1 
    x_3_11       Obj                                 0 
    x_4_0        assign_4                            1  Obj                                 0 
    x_4_0        capacity_0                         28 
    x_4_1        capacity_1                         28  assign_4                            1 
    x_4_1        Obj                                 0 
    x_4_2        Obj                                 0  capacity_2                         28 
    x_4_2        assign_4                            1 
    x_4_3        assign_4                            1  capacity_3                         28 
    x_4_3        Obj                                 0 
    x_4_4        capacity_4                         28  Obj                                 0 
    x_4_4        assign_4                            1 
    x_4_5        assign_4                            1  capacity_5                         28 
    x_4_5        Obj                                 0 
    x_4_6        capacity_6                         28  assign_4                            1 
    x_4_6        Obj                                 0 
    x_4_7        assign_4                            1  Obj                                 0 
    x_4_7        capacity_7                         28 
    x_4_8        Obj                                 0  assign_4                            1 
    x_4_8        capacity_8                         28 
    x_4_9        assign_4                            1  capacity_9                         28 
    x_4_9        Obj                                 0 
    x_4_10       Obj                                 0  assign_4                            1 
    x_4_10       capacity_10                        28 
    x_4_11       Obj                                 0  capacity_11                        28 
    x_4_11       assign_4                            1 
    x_5_0        assign_5                            1  Obj                                 0 
    x_5_0        capacity_0                         26 
    x_5_1        assign_5                            1  Obj                                 0 
    x_5_1        capacity_1                         26 
    x_5_2        capacity_2                         26  Obj                                 0 
    x_5_2        assign_5                            1 
    x_5_3        assign_5                            1  Obj                                 0 
    x_5_3        capacity_3                         26 
    x_5_4        capacity_4                         26  Obj                                 0 
    x_5_4        assign_5                            1 
    x_5_5        Obj                                 0  capacity_5                         26 
    x_5_5        assign_5                            1 
    x_5_6        Obj                                 0  capacity_6                         26 
    x_5_6        assign_5                            1 
    x_5_7        Obj                                 0  capacity_7                         26 
    x_5_7        assign_5                            1 
    x_5_8        Obj                                 0  assign_5                            1 
    x_5_8        capacity_8                         26 
    x_5_9        assign_5                            1  Obj                                 0 
    x_5_9        capacity_9                         26 
    x_5_10       assign_5                            1  Obj                                 0 
    x_5_10       capacity_10                        26 
    x_5_11       assign_5                            1  Obj                                 0 
    x_5_11       capacity_11                        26 
    x_6_0        assign_6                            1  Obj                                 0 
    x_6_0        capacity_0                         20 
    x_6_1        Obj                                 0  assign_6                            1 
    x_6_1        capacity_1                         20 
    x_6_2        capacity_2                         20  Obj                                 0 
    x_6_2        assign_6                            1 
    x_6_3        Obj                                 0  capacity_3                         20 
    x_6_3        assign_6                            1 
    x_6_4        Obj                                 0  capacity_4                         20 
    x_6_4        assign_6                            1 
    x_6_5        capacity_5                         20  Obj                                 0 
    x_6_5        assign_6                            1 
    x_6_6        capacity_6                         20  Obj                                 0 
    x_6_6        assign_6                            1 
    x_6_7        capacity_7                         20  Obj                                 0 
    x_6_7        assign_6                            1 
    x_6_8        Obj                                 0  capacity_8                         20 
    x_6_8        assign_6                            1 
    x_6_9        assign_6                            1  Obj                                 0 
    x_6_9        capacity_9                         20 
    x_6_10       Obj                                 0  assign_6                            1 
    x_6_10       capacity_10                        20 
    x_6_11       Obj                                 0  capacity_11                        20 
    x_6_11       assign_6                            1 
    x_7_0        assign_7                            1  Obj                                 0 
    x_7_0        capacity_0                         12 
    x_7_1        assign_7                            1  capacity_1                         12 
    x_7_1        Obj                                 0 
    x_7_2        assign_7                            1  Obj                                 0 
    x_7_2        capacity_2                         12 
    x_7_3        capacity_3                         12  assign_7                            1 
    x_7_3        Obj                                 0 
    x_7_4        capacity_4                         12  Obj                                 0 
    x_7_4        assign_7                            1 
    x_7_5        capacity_5                         12  assign_7                            1 
    x_7_5        Obj                                 0 
    x_7_6        Obj                                 0  assign_7                            1 
    x_7_6        capacity_6                         12 
    x_7_7        assign_7                            1  capacity_7                         12 
    x_7_7        Obj                                 0 
    x_7_8        assign_7                            1  Obj                                 0 
    x_7_8        capacity_8                         12 
    x_7_9        assign_7                            1  capacity_9                         12 
    x_7_9        Obj                                 0 
    x_7_10       Obj                                 0  assign_7                            1 
    x_7_10       capacity_10                        12 
    x_7_11       capacity_11                        12  Obj                                 0 
    x_7_11       assign_7                            1 
    x_8_0        assign_8                            1  capacity_0                         11 
    x_8_0        Obj                                 0 
    x_8_1        assign_8                            1  capacity_1                         11 
    x_8_1        Obj                                 0 
    x_8_2        Obj                                 0  assign_8                            1 
    x_8_2        capacity_2                         11 
    x_8_3        capacity_3                         11  Obj                                 0 
    x_8_3        assign_8                            1 
    x_8_4        Obj                                 0  capacity_4                         11 
    x_8_4        assign_8                            1 
    x_8_5        Obj                                 0  capacity_5                         11 
    x_8_5        assign_8                            1 
    x_8_6        Obj                                 0  assign_8                            1 
    x_8_6        capacity_6                         11 
    x_8_7        Obj                                 0  assign_8                            1 
    x_8_7        capacity_7                         11 
    x_8_8        Obj                                 0  assign_8                            1 
    x_8_8        capacity_8                         11 
    x_8_9        capacity_9                         11  assign_8                            1 
    x_8_9        Obj                                 0 
    x_8_10       assign_8                            1  capacity_10                        11 
    x_8_10       Obj                                 0 
    x_8_11       capacity_11                        11  Obj                                 0 
    x_8_11       assign_8                            1 
    x_9_0        Obj                                 0  capacity_0                         22 
    x_9_0        assign_9                            1 
    x_9_1        Obj                                 0  capacity_1                         22 
    x_9_1        assign_9                            1 
    x_9_2        assign_9                            1  Obj                                 0 
    x_9_2        capacity_2                         22 
    x_9_3        capacity_3                         22  assign_9                            1 
    x_9_3        Obj                                 0 
    x_9_4        assign_9                            1  capacity_4                         22 
    x_9_4        Obj                                 0 
    x_9_5        capacity_5                         22  Obj                                 0 
    x_9_5        assign_9                            1 
    x_9_6        Obj                                 0  capacity_6                         22 
    x_9_6        assign_9                            1 
    x_9_7        assign_9                            1  capacity_7                         22 
    x_9_7        Obj                                 0 
    x_9_8        capacity_8                         22  Obj                                 0 
    x_9_8        assign_9                            1 
    x_9_9        assign_9                            1  Obj                                 0 
    x_9_9        capacity_9                         22 
    x_9_10       assign_9                            1  capacity_10                        22 
    x_9_10       Obj                                 0 
    x_9_11       capacity_11                        22  assign_9                            1 
    x_9_11       Obj                                 0 
    x_10_0       Obj                                 0  capacity_0                         11 
    x_10_0       assign_10                           1 
    x_10_1       Obj                                 0  capacity_1                         11 
    x_10_1       assign_10                           1 
    x_10_2       Obj                                 0  assign_10                           1 
    x_10_2       capacity_2                         11 
    x_10_3       capacity_3                         11  assign_10                           1 
    x_10_3       Obj                                 0 
    x_10_4       Obj                                 0  capacity_4                         11 
    x_10_4       assign_10                           1 
    x_10_5       assign_10                           1  Obj                                 0 
    x_10_5       capacity_5                         11 
    x_10_6       capacity_6                         11  Obj                                 0 
    x_10_6       assign_10                           1 
    x_10_7       assign_10                           1  capacity_7                         11 
    x_10_7       Obj                                 0 
    x_10_8       Obj                                 0  capacity_8                         11 
    x_10_8       assign_10                           1 
    x_10_9       capacity_9                         11  Obj                                 0 
    x_10_9       assign_10                           1 
    x_10_10      Obj                                 0  capacity_10                        11 
    x_10_10      assign_10                           1 
    x_10_11      assign_10                           1  capacity_11                        11 
    x_10_11      Obj                                 0 
    x_11_0       assign_11                           1  Obj                                 0 
    x_11_0       capacity_0                         13 
    x_11_1       Obj                                 0  assign_11                           1 
    x_11_1       capacity_1                         13 
    x_11_2       Obj                                 0  capacity_2                         13 
    x_11_2       assign_11                           1 
    x_11_3       capacity_3                         13  Obj                                 0 
    x_11_3       assign_11                           1 
    x_11_4       assign_11                           1  capacity_4                         13 
    x_11_4       Obj                                 0 
    x_11_5       assign_11                           1  capacity_5                         13 
    x_11_5       Obj                                 0 
    x_11_6       assign_11                           1  Obj                                 0 
    x_11_6       capacity_6                         13 
    x_11_7       Obj                                 0  assign_11                           1 
    x_11_7       capacity_7                         13 
    x_11_8       capacity_8                         13  Obj                                 0 
    x_11_8       assign_11                           1 
    x_11_9       assign_11                           1  Obj                                 0 
    x_11_9       capacity_9                         13 
    x_11_10      assign_11                           1  Obj                                 0 
    x_11_10      capacity_10                        13 
    x_11_11      assign_11                           1  capacity_11                        13 
    x_11_11      Obj                                 0 
    x_12_0       capacity_0                         23  assign_12                           1 
    x_12_0       Obj                                 0 
    x_12_1       assign_12                           1  Obj                                 0 
    x_12_1       capacity_1                         23 
    x_12_2       assign_12                           1  Obj                                 0 
    x_12_2       capacity_2                         23 
    x_12_3       Obj                                 0  capacity_3                         23 
    x_12_3       assign_12                           1 
    x_12_4       Obj                                 0  capacity_4                         23 
    x_12_4       assign_12                           1 
    x_12_5       assign_12                           1  capacity_5                         23 
    x_12_5       Obj                                 0 
    x_12_6       Obj                                 0  assign_12                           1 
    x_12_6       capacity_6                         23 
    x_12_7       assign_12                           1  capacity_7                         23 
    x_12_7       Obj                                 0 
    x_12_8       capacity_8                         23  Obj                                 0 
    x_12_8       assign_12                           1 
    x_12_9       capacity_9                         23  assign_12                           1 
    x_12_9       Obj                                 0 
    x_12_10      Obj                                 0  capacity_10                        23 
    x_12_10      assign_12                           1 
    x_12_11      Obj                                 0  capacity_11                        23 
    x_12_11      assign_12                           1 
    x_13_0       Obj                                 0  capacity_0                         11 
    x_13_0       assign_13                           1 
    x_13_1       assign_13                           1  Obj                                 0 
    x_13_1       capacity_1                         11 
    x_13_2       assign_13                           1  capacity_2                         11 
    x_13_2       Obj                                 0 
    x_13_3       Obj                                 0  assign_13                           1 
    x_13_3       capacity_3                         11 
    x_13_4       Obj                                 0  capacity_4                         11 
    x_13_4       assign_13                           1 
    x_13_5       capacity_5                         11  Obj                                 0 
    x_13_5       assign_13                           1 
    x_13_6       assign_13                           1  capacity_6                         11 
    x_13_6       Obj                                 0 
    x_13_7       Obj                                 0  capacity_7                         11 
    x_13_7       assign_13                           1 
    x_13_8       assign_13                           1  capacity_8                         11 
    x_13_8       Obj                                 0 
    x_13_9       assign_13                           1  capacity_9                         11 
    x_13_9       Obj                                 0 
    x_13_10      Obj                                 0  capacity_10                        11 
    x_13_10      assign_13                           1 
    x_13_11      Obj                                 0  assign_13                           1 
    x_13_11      capacity_11                        11 
    x_14_0       Obj                                 0  assign_14                           1 
    x_14_0       capacity_0                         28 
    x_14_1       capacity_1                         28  Obj                                 0 
    x_14_1       assign_14                           1 
    x_14_2       Obj                                 0  assign_14                           1 
    x_14_2       capacity_2                         28 
    x_14_3       Obj                                 0  capacity_3                         28 
    x_14_3       assign_14                           1 
    x_14_4       assign_14                           1  capacity_4                         28 
    x_14_4       Obj                                 0 
    x_14_5       assign_14                           1  Obj                                 0 
    x_14_5       capacity_5                         28 
    x_14_6       Obj                                 0  assign_14                           1 
    x_14_6       capacity_6                         28 
    x_14_7       capacity_7                         28  Obj                                 0 
    x_14_7       assign_14                           1 
    x_14_8       assign_14                           1  Obj                                 0 
    x_14_8       capacity_8                         28 
    x_14_9       Obj                                 0  assign_14                           1 
    x_14_9       capacity_9                         28 
    x_14_10      Obj                                 0  capacity_10                        28 
    x_14_10      assign_14                           1 
    x_14_11      Obj                                 0  capacity_11                        28 
    x_14_11      assign_14                           1 
    x_15_0       Obj                                 0  assign_15                           1 
    x_15_0       capacity_0                         13 
    x_15_1       capacity_1                         13  Obj                                 0 
    x_15_1       assign_15                           1 
    x_15_2       assign_15                           1  capacity_2                         13 
    x_15_2       Obj                                 0 
    x_15_3       Obj                                 0  assign_15                           1 
    x_15_3       capacity_3                         13 
    x_15_4       assign_15                           1  Obj                                 0 
    x_15_4       capacity_4                         13 
    x_15_5       Obj                                 0  capacity_5                         13 
    x_15_5       assign_15                           1 
    x_15_6       Obj                                 0  assign_15                           1 
    x_15_6       capacity_6                         13 
    x_15_7       assign_15                           1  capacity_7                         13 
    x_15_7       Obj                                 0 
    x_15_8       Obj                                 0  assign_15                           1 
    x_15_8       capacity_8                         13 
    x_15_9       assign_15                           1  capacity_9                         13 
    x_15_9       Obj                                 0 
    x_15_10      assign_15                           1  Obj                                 0 
    x_15_10      capacity_10                        13 
    x_15_11      assign_15                           1  capacity_11                        13 
    x_15_11      Obj                                 0 
    x_16_0       Obj                                 0  capacity_0                         27 
    x_16_0       assign_16                           1 
    x_16_1       Obj                                 0  assign_16                           1 
    x_16_1       capacity_1                         27 
    x_16_2       capacity_2                         27  assign_16                           1 
    x_16_2       Obj                                 0 
    x_16_3       assign_16                           1  capacity_3                         27 
    x_16_3       Obj                                 0 
    x_16_4       assign_16                           1  Obj                                 0 
    x_16_4       capacity_4                         27 
    x_16_5       Obj                                 0  capacity_5                         27 
    x_16_5       assign_16                           1 
    x_16_6       assign_16                           1  capacity_6                         27 
    x_16_6       Obj                                 0 
    x_16_7       assign_16                           1  capacity_7                         27 
    x_16_7       Obj                                 0 
    x_16_8       capacity_8                         27  assign_16                           1 
    x_16_8       Obj                                 0 
    x_16_9       assign_16                           1  Obj                                 0 
    x_16_9       capacity_9                         27 
    x_16_10      capacity_10                        27  assign_16                           1 
    x_16_10      Obj                                 0 
    x_16_11      assign_16                           1  Obj                                 0 
    x_16_11      capacity_11                        27 
    x_17_0       Obj                                 0  capacity_0                         24 
    x_17_0       assign_17                           1 
    x_17_1       assign_17                           1  capacity_1                         24 
    x_17_1       Obj                                 0 
    x_17_2       assign_17                           1  capacity_2                         24 
    x_17_2       Obj                                 0 
    x_17_3       assign_17                           1  Obj                                 0 
    x_17_3       capacity_3                         24 
    x_17_4       capacity_4                         24  assign_17                           1 
    x_17_4       Obj                                 0 
    x_17_5       assign_17                           1  Obj                                 0 
    x_17_5       capacity_5                         24 
    x_17_6       assign_17                           1  capacity_6                         24 
    x_17_6       Obj                                 0 
    x_17_7       assign_17                           1  Obj                                 0 
    x_17_7       capacity_7                         24 
    x_17_8       Obj                                 0  assign_17                           1 
    x_17_8       capacity_8                         24 
    x_17_9       capacity_9                         24  assign_17                           1 
    x_17_9       Obj                                 0 
    x_17_10      capacity_10                        24  assign_17                           1 
    x_17_10      Obj                                 0 
    x_17_11      assign_17                           1  capacity_11                        24 
    x_17_11      Obj                                 0 
    x_18_0       assign_18                           1  capacity_0                         11 
    x_18_0       Obj                                 0 
    x_18_1       Obj                                 0  capacity_1                         11 
    x_18_1       assign_18                           1 
    x_18_2       Obj                                 0  assign_18                           1 
    x_18_2       capacity_2                         11 
    x_18_3       capacity_3                         11  assign_18                           1 
    x_18_3       Obj                                 0 
    x_18_4       capacity_4                         11  assign_18                           1 
    x_18_4       Obj                                 0 
    x_18_5       capacity_5                         11  assign_18                           1 
    x_18_5       Obj                                 0 
    x_18_6       Obj                                 0  capacity_6                         11 
    x_18_6       assign_18                           1 
    x_18_7       capacity_7                         11  Obj                                 0 
    x_18_7       assign_18                           1 
    x_18_8       Obj                                 0  assign_18                           1 
    x_18_8       capacity_8                         11 
    x_18_9       assign_18                           1  Obj                                 0 
    x_18_9       capacity_9                         11 
    x_18_10      capacity_10                        11  assign_18                           1 
    x_18_10      Obj                                 0 
    x_18_11      assign_18                           1  Obj                                 0 
    x_18_11      capacity_11                        11 
    x_19_0       capacity_0                         20  Obj                                 0 
    x_19_0       assign_19                           1 
    x_19_1       Obj                                 0  capacity_1                         20 
    x_19_1       assign_19                           1 
    x_19_2       capacity_2                         20  assign_19                           1 
    x_19_2       Obj                                 0 
    x_19_3       Obj                                 0  capacity_3                         20 
    x_19_3       assign_19                           1 
    x_19_4       capacity_4                         20  Obj                                 0 
    x_19_4       assign_19                           1 
    x_19_5       assign_19                           1  capacity_5                         20 
    x_19_5       Obj                                 0 
    x_19_6       capacity_6                         20  assign_19                           1 
    x_19_6       Obj                                 0 
    x_19_7       assign_19                           1  capacity_7                         20 
    x_19_7       Obj                                 0 
    x_19_8       capacity_8                         20  assign_19                           1 
    x_19_8       Obj                                 0 
    x_19_9       capacity_9                         20  Obj                                 0 
    x_19_9       assign_19                           1 
    x_19_10      assign_19                           1  Obj                                 0 
    x_19_10      capacity_10                        20 
    x_19_11      capacity_11                        20  assign_19                           1 
    x_19_11      Obj                                 0 
    x_20_0       assign_20                           1  Obj                                 0 
    x_20_0       capacity_0                         23 
    x_20_1       capacity_1                         23  assign_20                           1 
    x_20_1       Obj                                 0 
    x_20_2       assign_20                           1  capacity_2                         23 
    x_20_2       Obj                                 0 
    x_20_3       capacity_3                         23  Obj                                 0 
    x_20_3       assign_20                           1 
    x_20_4       assign_20                           1  capacity_4                         23 
    x_20_4       Obj                                 0 
    x_20_5       assign_20                           1  capacity_5                         23 
    x_20_5       Obj                                 0 
    x_20_6       Obj                                 0  assign_20                           1 
    x_20_6       capacity_6                         23 
    x_20_7       capacity_7                         23  assign_20                           1 
    x_20_7       Obj                                 0 
    x_20_8       assign_20                           1  capacity_8                         23 
    x_20_8       Obj                                 0 
    x_20_9       assign_20                           1  Obj                                 0 
    x_20_9       capacity_9                         23 
    x_20_10      assign_20                           1  capacity_10                        23 
    x_20_10      Obj                                 0 
    x_20_11      assign_20                           1  Obj                                 0 
    x_20_11      capacity_11                        23 
    x_21_0       assign_21                           1  capacity_0                         19 
    x_21_0       Obj                                 0 
    x_21_1       assign_21                           1  capacity_1                         19 
    x_21_1       Obj                                 0 
    x_21_2       Obj                                 0  assign_21                           1 
    x_21_2       capacity_2                         19 
    x_21_3       assign_21                           1  Obj                                 0 
    x_21_3       capacity_3                         19 
    x_21_4       assign_21                           1  Obj                                 0 
    x_21_4       capacity_4                         19 
    x_21_5       Obj                                 0  assign_21                           1 
    x_21_5       capacity_5                         19 
    x_21_6       assign_21                           1  Obj                                 0 
    x_21_6       capacity_6                         19 
    x_21_7       capacity_7                         19  Obj                                 0 
    x_21_7       assign_21                           1 
    x_21_8       capacity_8                         19  assign_21                           1 
    x_21_8       Obj                                 0 
    x_21_9       assign_21                           1  capacity_9                         19 
    x_21_9       Obj                                 0 
    x_21_10      assign_21                           1  Obj                                 0 
    x_21_10      capacity_10                        19 
    x_21_11      Obj                                 0  capacity_11                        19 
    x_21_11      assign_21                           1 
    x_22_0       assign_22                           1  Obj                                 0 
    x_22_0       capacity_0                         18 
    x_22_1       assign_22                           1  capacity_1                         18 
    x_22_1       Obj                                 0 
    x_22_2       capacity_2                         18  assign_22                           1 
    x_22_2       Obj                                 0 
    x_22_3       capacity_3                         18  assign_22                           1 
    x_22_3       Obj                                 0 
    x_22_4       Obj                                 0  capacity_4                         18 
    x_22_4       assign_22                           1 
    x_22_5       Obj                                 0  capacity_5                         18 
    x_22_5       assign_22                           1 
    x_22_6       assign_22                           1  Obj                                 0 
    x_22_6       capacity_6                         18 
    x_22_7       capacity_7                         18  assign_22                           1 
    x_22_7       Obj                                 0 
    x_22_8       assign_22                           1  Obj                                 0 
    x_22_8       capacity_8                         18 
    x_22_9       Obj                                 0  assign_22                           1 
    x_22_9       capacity_9                         18 
    x_22_10      Obj                                 0  capacity_10                        18 
    x_22_10      assign_22                           1 
    x_22_11      capacity_11                        18  Obj                                 0 
    x_22_11      assign_22                           1 
    x_23_0       assign_23                           1  capacity_0                         25 
    x_23_0       Obj                                 0 
    x_23_1       capacity_1                         25  Obj                                 0 
    x_23_1       assign_23                           1 
    x_23_2       capacity_2                         25  Obj                                 0 
    x_23_2       assign_23                           1 
    x_23_3       capacity_3                         25  assign_23                           1 
    x_23_3       Obj                                 0 
    x_23_4       capacity_4                         25  assign_23                           1 
    x_23_4       Obj                                 0 
    x_23_5       assign_23                           1  capacity_5                         25 
    x_23_5       Obj                                 0 
    x_23_6       assign_23                           1  Obj                                 0 
    x_23_6       capacity_6                         25 
    x_23_7       assign_23                           1  capacity_7                         25 
    x_23_7       Obj                                 0 
    x_23_8       assign_23                           1  capacity_8                         25 
    x_23_8       Obj                                 0 
    x_23_9       capacity_9                         25  Obj                                 0 
    x_23_9       assign_23                           1 
    x_23_10      assign_23                           1  capacity_10                        25 
    x_23_10      Obj                                 0 
    x_23_11      Obj                                 0  assign_23                           1 
    x_23_11      capacity_11                        25 
    x_24_0       capacity_0                         28  Obj                                 0 
    x_24_0       assign_24                           1 
    x_24_1       assign_24                           1  capacity_1                         28 
    x_24_1       Obj                                 0 
    x_24_2       Obj                                 0  capacity_2                         28 
    x_24_2       assign_24                           1 
    x_24_3       capacity_3                         28  assign_24                           1 
    x_24_3       Obj                                 0 
    x_24_4       capacity_4                         28  assign_24                           1 
    x_24_4       Obj                                 0 
    x_24_5       Obj                                 0  capacity_5                         28 
    x_24_5       assign_24                           1 
    x_24_6       capacity_6                         28  assign_24                           1 
    x_24_6       Obj                                 0 
    x_24_7       assign_24                           1  capacity_7                         28 
    x_24_7       Obj                                 0 
    x_24_8       capacity_8                         28  Obj                                 0 
    x_24_8       assign_24                           1 
    x_24_9       capacity_9                         28  assign_24                           1 
    x_24_9       Obj                                 0 
    x_24_10      capacity_10                        28  Obj                                 0 
    x_24_10      assign_24                           1 
    x_24_11      assign_24                           1  capacity_11                        28 
    x_24_11      Obj                                 0 
    INTEND       'MARKER'                               'INTEND'                              
RHS
    RHS          assign_0                            1  assign_1                            1 
    RHS          assign_2                            1  assign_3                            1 
    RHS          assign_4                            1  assign_5                            1 
    RHS          assign_6                            1  assign_7                            1 
    RHS          assign_8                            1  assign_9                            1 
    RHS          assign_10                           1  assign_11                           1 
    RHS          assign_12                           1  assign_13                           1 
    RHS          assign_14                           1  assign_15                           1 
    RHS          assign_16                           1  assign_17                           1 
    RHS          assign_18                           1  assign_19                           1 
    RHS          assign_20                           1  assign_21                           1 
    RHS          assign_22                           1  assign_23                           1 
    RHS          assign_24                           1  capacity_0                          0 
    RHS          capacity_1                          0  capacity_2                          0 
    RHS          capacity_3                          0  capacity_4                          0 
    RHS          capacity_5                          0  capacity_6                          0 
    RHS          capacity_7                          0  capacity_8                          0 
    RHS          capacity_9                          0  capacity_10                         0 
    RHS          capacity_11                         0  symmetry_0                          0 
    RHS          symmetry_1                          0  symmetry_2                          0 
    RHS          symmetry_3                          0  symmetry_4                          0 
    RHS          symmetry_5                          0  symmetry_6                          0 
    RHS          symmetry_7                          0  symmetry_8                          0 
    RHS          symmetry_9                          0  symmetry_10                         0 
BOUNDS
 BV Bound        y_0                                   
 BV Bound        y_1                                   
 BV Bound        y_2                                   
 BV Bound        y_3                                   
 BV Bound        y_4                                   
 BV Bound        y_5                                   
 BV Bound        y_6                                   
 BV Bound        y_7                                   
 BV Bound        y_8                                   
 BV Bound        y_9                                   
 BV Bound        y_10                                  
 BV Bound        y_11                                  
 BV Bound        x_0_0                                 
 BV Bound        x_0_1                                 
 BV Bound        x_0_2                                 
 BV Bound        x_0_3                                 
 BV Bound        x_0_4                                 
 BV Bound        x_0_5                                 
 BV Bound        x_0_6                                 
 BV Bound        x_0_7                                 
 BV Bound        x_0_8                                 
 BV Bound        x_0_9                                 
 BV Bound        x_0_10                                
 BV Bound        x_0_11                                
 BV Bound        x_1_0                                 
 BV Bound        x_1_1                                 
 BV Bound        x_1_2                                 
 BV Bound        x_1_3                                 
 BV Bound        x_1_4                                 
 BV Bound        x_1_5                                 
 BV Bound        x_1_6                                 
 BV Bound        x_1_7                                 
 BV Bound        x_1_8                                 
 BV Bound        x_1_9                                 
 BV Bound        x_1_10                                
 BV Bound        x_1_11                                
 BV Bound        x_2_0                                 
 BV Bound        x_2_1                                 
 BV Bound        x_2_2                                 
 BV Bound        x_2_3                                 
 BV Bound        x_2_4                                 
 BV Bound        x_2_5                                 
 BV Bound        x_2_6                                 
 BV Bound        x_2_7                                 
 BV Bound        x_2_8                                 
 BV Bound        x_2_9                                 
 BV Bound        x_2_10                                
 BV Bound        x_2_11                                
 BV Bound        x_3_0                                 
 BV Bound        x_3_1                                 
 BV Bound        x_3_2                                 
 BV Bound        x_3_3                                 
 BV Bound        x_3_4                                 
 BV Bound        x_3_5                                 
 BV Bound        x_3_6                                 
 BV Bound        x_3_7                                 
 BV Bound        x_3_8                                 
 BV Bound        x_3_9                                 
 BV Bound        x_3_10                                
 BV Bound        x_3_11                                
 BV Bound        x_4_0                                 
 BV Bound        x_4_1                                 
 BV Bound        x_4_2                                 
 BV Bound        x_4_3                                 
 BV Bound        x_4_4                                 
 BV Bound        x_4_5                                 
 BV Bound        x_4_6                                 
 BV Bound        x_4_7                                 
 BV Bound        x_4_8                                 
 BV Bound        x_4_9                                 
 BV Bound        x_4_10                                
 BV Bound        x_4_11                                
 BV Bound        x_5_0                                 
 BV Bound        x_5_1                                 
 BV Bound        x_5_2                                 
 BV Bound        x_5_3                                 
 BV Bound        x_5_4                                 
 BV Bound        x_5_5                                 
 BV Bound        x_5_6                                 
 BV Bound        x_5_7                                 
 BV Bound        x_5_8                                 
 BV Bound        x_5_9                                 
 BV Bound        x_5_10                                
 BV Bound        x_5_11                                
 BV Bound        x_6_0                                 
 BV Bound        x_6_1                                 
 BV Bound        x_6_2                                 
 BV Bound        x_6_3                                 
 BV Bound        x_6_4                                 
 BV Bound        x_6_5                                 
 BV Bound        x_6_6                                 
 BV Bound        x_6_7                                 
 BV Bound        x_6_8                                 
 BV Bound        x_6_9                                 
 BV Bound        x_6_10                                
 BV Bound        x_6_11                                
 BV Bound        x_7_0                                 
 BV Bound        x_7_1                                 
 BV Bound        x_7_2                                 
 BV Bound        x_7_3                                 
 BV Bound        x_7_4                                 
 BV Bound        x_7_5                                 
 BV Bound        x_7_6                                 
 BV Bound        x_7_7                                 
 BV Bound        x_7_8                                 
 BV Bound        x_7_9                                 
 BV Bound        x_7_10                                
 BV Bound        x_7_11                                
 BV Bound        x_8_0                                 
 BV Bound        x_8_1                                 
 BV Bound        x_8_2                                 
 BV Bound        x_8_3                                 
 BV Bound        x_8_4                                 
 BV Bound        x_8_5                                 
 BV Bound        x_8_6                                 
 BV Bound        x_8_7                                 
 BV Bound        x_8_8                                 
 BV Bound        x_8_9                                 
 BV Bound        x_8_10                                
 BV Bound        x_8_11                                
 BV Bound        x_9_0                                 
 BV Bound        x_9_1                                 
 BV Bound        x_9_2                                 
 BV Bound        x_9_3                                 
 BV Bound        x_9_4                                 
 BV Bound        x_9_5                                 
 BV Bound        x_9_6                                 
 BV Bound        x_9_7                                 
 BV Bound        x_9_8                                 
 BV Bound        x_9_9                                 
 BV Bound        x_9_10                                
 BV Bound        x_9_11                                
 BV Bound        x_10_0                                
 BV Bound        x_10_1                                
 BV Bound        x_10_2                                
 BV Bound        x_10_3                                
 BV Bound        x_10_4                                
 BV Bound        x_10_5                                
 BV Bound        x_10_6                                
 BV Bound        x_10_7                                
 BV Bound        x_10_8                                
 BV Bound        x_10_9                                
 BV Bound        x_10_10                               
 BV Bound        x_10_11                               
 BV Bound        x_11_0                                
 BV Bound        x_11_1                                
 BV Bound        x_11_2                                
 BV Bound        x_11_3                                
 BV Bound        x_11_4                                
 BV Bound        x_11_5                                
 BV Bound        x_11_6                                
 BV Bound        x_11_7                                
 BV Bound        x_11_8                                
 BV Bound        x_11_9                                
 BV Bound        x_11_10                               
 BV Bound        x_11_11                               
 BV Bound        x_12_0                                
 BV Bound        x_12_1                                
 BV Bound        x_12_2                                
 BV Bound        x_12_3                                
 BV Bound        x_12_4                                
 BV Bound        x_12_5                                
 BV Bound        x_12_6                                
 BV Bound        x_12_7                                
 BV Bound        x_12_8                                
 BV Bound        x_12_9                                
 BV Bound        x_12_10                               
 BV Bound        x_12_11                               
 BV Bound        x_13_0                                
 BV Bound        x_13_1                                
 BV Bound        x_13_2                                
 BV Bound        x_13_3                                
 BV Bound        x_13_4                                
 BV Bound        x_13_5                                
 BV Bound        x_13_6                                
 BV Bound        x_13_7                                
 BV Bound        x_13_8                                
 BV Bound        x_13_9                                
 BV Bound        x_13_10                               
 BV Bound        x_13_11                               
 BV Bound        x_14_0                                
 BV Bound        x_14_1                                
 BV Bound        x_14_2                                
 BV Bound        x_14_3                                
 BV Bound        x_14_4                                
 BV Bound        x_14_5                                
 BV Bound        x_14_6                                
 BV Bound        x_14_7                                
 BV Bound        x_14_8                                
 BV Bound        x_14_9                                
 BV Bound        x_14_10                               
 BV Bound        x_14_11                               
 BV Bound        x_15_0                                
 BV Bound        x_15_1                                
 BV Bound        x_15_2                                
 BV Bound        x_15_3                                
 BV Bound        x_15_4                                
 BV Bound        x_15_5                                
 BV Bound        x_15_6                                
 BV Bound        x_15_7                                
 BV Bound        x_15_8                                
 BV Bound        x_15_9                                
 BV Bound        x_15_10                               
 BV Bound        x_15_11                               
 BV Bound        x_16_0                                
 BV Bound        x_16_1                                
 BV Bound        x_16_2                                
 BV Bound        x_16_3                                
 BV Bound        x_16_4                                
 BV Bound        x_16_5                                
 BV Bound        x_16_6                                
 BV Bound        x_16_7                                
 BV Bound        x_16_8                                
 BV Bound        x_16_9                                
 BV Bound        x_16_10                               
 BV Bound        x_16_11                               
 BV Bound        x_17_0                                
 BV Bound        x_17_1                                
 BV Bound        x_17_2                                
 BV Bound        x_17_3                                
 BV Bound        x_17_4                                
 BV Bound        x_17_5                                
 BV Bound        x_17_6                                
 BV Bound        x_17_7                                
 BV Bound        x_17_8                                
 BV Bound        x_17_9                                
 BV Bound        x_17_10                               
 BV Bound        x_17_11                               
 BV Bound        x_18_0                                
 BV Bound        x_18_1                                
 BV Bound        x_18_2                                
 BV Bound        x_18_3                                
 BV Bound        x_18_4                                
 BV Bound        x_18_5                                
 BV Bound        x_18_6                                
 BV Bound        x_18_7                                
 BV Bound        x_18_8                                
 BV Bound        x_18_9                                
 BV Bound        x_18_10                               
 BV Bound        x_18_11                               
 BV Bound        x_19_0                                
 BV Bound        x_19_1                                
 BV Bound        x_19_2                                
 BV Bound        x_19_3                                
 BV Bound        x_19_4                                
 BV Bound        x_19_5                                
 BV Bound        x_19_6                                
 BV Bound        x_19_7                                
 BV Bound        x_19_8                                
 BV Bound        x_19_9                                
 BV Bound        x_19_10                               
 BV Bound        x_19_11                               
 BV Bound        x_20_0                                
 BV Bound        x_20_1                                
 BV Bound        x_20_2                                
 BV Bound        x_20_3                                
 BV Bound        x_20_4                                
 BV Bound        x_20_5                                
 BV Bound        x_20_6                                
 BV Bound        x_20_7                                
 BV Bound        x_20_8                                
 BV Bound        x_20_9                                
 BV Bound        x_20_10                               
 BV Bound        x_20_11                               
 BV Bound        x_21_0                                
 BV Bound        x_21_1                                
 BV Bound        x_21_2                                
 BV Bound        x_21_3                                
 BV Bound        x_21_4                                
 BV Bound        x_21_5                                
 BV Bound        x_21_6                                
 BV Bound        x_21_7                                
 BV Bound        x_21_8                                
 BV Bound        x_21_9                                
 BV Bound        x_21_10                               
 BV Bound        x_21_11                               
 BV Bound        x_22_0                                
 BV Bound        x_22_1                                
 BV Bound        x_22_2                                
 BV Bound        x_22_3                                
 BV Bound        x_22_4                                
 BV Bound        x_22_5                                
 BV Bound        x_22_6                                
 BV Bound        x_22_7                                
 BV Bound        x_22_8                                
 BV Bound        x_22_9                                
 BV Bound        x_22_10                               
 BV Bound        x_22_11                               
 BV Bound        x_23_0                                
 BV Bound        x_23_1                                
 BV Bound        x_23_2                                
 BV Bound        x_23_3                                
 BV Bound        x_23_4                                
 BV Bound        x_23_5                                
 BV Bound        x_23_6                                
 BV Bound        x_23_7                                
 BV Bound        x_23_8                                
 BV Bound        x_23_9                                
 BV Bound        x_23_10                               
 BV Bound        x_23_11                               
 BV Bound        x_24_0                                
 BV Bound        x_24_1                                
 BV Bound        x_24_2                                
 BV Bound        x_24_3                                
 BV Bound        x_24_4                                
 BV Bound        x_24_5                                
 BV Bound        x_24_6                                
 BV Bound        x_24_7                                
 BV Bound        x_24_8                                
 BV Bound        x_24_9                                
 BV Bound        x_24_10                               
 BV Bound        x_24_11                               
ENDATA