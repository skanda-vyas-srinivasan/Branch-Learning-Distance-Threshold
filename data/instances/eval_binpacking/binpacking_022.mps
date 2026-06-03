* SCIP STATISTICS
*   Problem name     : model
*   Variables        : 290 (290 binary, 0 integer, 0 implicit integer, 0 continuous)
*   Constraints      : 47
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
 E  assign_25 
 E  assign_26 
 E  assign_27 
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
 G  symmetry_0 
 G  symmetry_1 
 G  symmetry_2 
 G  symmetry_3 
 G  symmetry_4 
 G  symmetry_5 
 G  symmetry_6 
 G  symmetry_7 
 G  symmetry_8 
COLUMNS
    INTSTART    'MARKER'                              'INTORG'                             
    y_0         Obj                                1  capacity_0                       -65 
    y_0         symmetry_0                         1 
    y_1         Obj                                1  symmetry_1                         1 
    y_1         capacity_1                       -65  symmetry_0                        -1 
    y_2         Obj                                1  symmetry_2                         1 
    y_2         symmetry_1                        -1  capacity_2                       -65 
    y_3         symmetry_2                        -1  capacity_3                       -65 
    y_3         Obj                                1  symmetry_3                         1 
    y_4         Obj                                1  symmetry_3                        -1 
    y_4         symmetry_4                         1  capacity_4                       -65 
    y_5         symmetry_4                        -1  symmetry_5                         1 
    y_5         Obj                                1  capacity_5                       -65 
    y_6         symmetry_5                        -1  capacity_6                       -65 
    y_6         Obj                                1  symmetry_6                         1 
    y_7         capacity_7                       -65  symmetry_6                        -1 
    y_7         Obj                                1  symmetry_7                         1 
    y_8         symmetry_7                        -1  Obj                                1 
    y_8         symmetry_8                         1  capacity_8                       -65 
    y_9         Obj                                1  capacity_9                       -65 
    y_9         symmetry_8                        -1 
    x_0_0       capacity_0                        23  Obj                                0 
    x_0_0       assign_0                           1 
    x_0_1       assign_0                           1  Obj                                0 
    x_0_1       capacity_1                        23 
    x_0_2       assign_0                           1  Obj                                0 
    x_0_2       capacity_2                        23 
    x_0_3       Obj                                0  capacity_3                        23 
    x_0_3       assign_0                           1 
    x_0_4       Obj                                0  capacity_4                        23 
    x_0_4       assign_0                           1 
    x_0_5       capacity_5                        23  Obj                                0 
    x_0_5       assign_0                           1 
    x_0_6       Obj                                0  assign_0                           1 
    x_0_6       capacity_6                        23 
    x_0_7       assign_0                           1  Obj                                0 
    x_0_7       capacity_7                        23 
    x_0_8       Obj                                0  capacity_8                        23 
    x_0_8       assign_0                           1 
    x_0_9       assign_0                           1  Obj                                0 
    x_0_9       capacity_9                        23 
    x_1_0       Obj                                0  capacity_0                        23 
    x_1_0       assign_1                           1 
    x_1_1       assign_1                           1  capacity_1                        23 
    x_1_1       Obj                                0 
    x_1_2       capacity_2                        23  Obj                                0 
    x_1_2       assign_1                           1 
    x_1_3       Obj                                0  capacity_3                        23 
    x_1_3       assign_1                           1 
    x_1_4       assign_1                           1  Obj                                0 
    x_1_4       capacity_4                        23 
    x_1_5       Obj                                0  assign_1                           1 
    x_1_5       capacity_5                        23 
    x_1_6       Obj                                0  capacity_6                        23 
    x_1_6       assign_1                           1 
    x_1_7       assign_1                           1  Obj                                0 
    x_1_7       capacity_7                        23 
    x_1_8       capacity_8                        23  Obj                                0 
    x_1_8       assign_1                           1 
    x_1_9       capacity_9                        23  assign_1                           1 
    x_1_9       Obj                                0 
    x_2_0       capacity_0                        21  assign_2                           1 
    x_2_0       Obj                                0 
    x_2_1       Obj                                0  assign_2                           1 
    x_2_1       capacity_1                        21 
    x_2_2       Obj                                0  assign_2                           1 
    x_2_2       capacity_2                        21 
    x_2_3       Obj                                0  capacity_3                        21 
    x_2_3       assign_2                           1 
    x_2_4       assign_2                           1  capacity_4                        21 
    x_2_4       Obj                                0 
    x_2_5       Obj                                0  assign_2                           1 
    x_2_5       capacity_5                        21 
    x_2_6       assign_2                           1  capacity_6                        21 
    x_2_6       Obj                                0 
    x_2_7       Obj                                0  assign_2                           1 
    x_2_7       capacity_7                        21 
    x_2_8       capacity_8                        21  Obj                                0 
    x_2_8       assign_2                           1 
    x_2_9       capacity_9                        21  Obj                                0 
    x_2_9       assign_2                           1 
    x_3_0       capacity_0                        29  Obj                                0 
    x_3_0       assign_3                           1 
    x_3_1       capacity_1                        29  Obj                                0 
    x_3_1       assign_3                           1 
    x_3_2       assign_3                           1  capacity_2                        29 
    x_3_2       Obj                                0 
    x_3_3       Obj                                0  assign_3                           1 
    x_3_3       capacity_3                        29 
    x_3_4       capacity_4                        29  assign_3                           1 
    x_3_4       Obj                                0 
    x_3_5       Obj                                0  capacity_5                        29 
    x_3_5       assign_3                           1 
    x_3_6       assign_3                           1  Obj                                0 
    x_3_6       capacity_6                        29 
    x_3_7       Obj                                0  assign_3                           1 
    x_3_7       capacity_7                        29 
    x_3_8       Obj                                0  assign_3                           1 
    x_3_8       capacity_8                        29 
    x_3_9       capacity_9                        29  assign_3                           1 
    x_3_9       Obj                                0 
    x_4_0       capacity_0                        13  Obj                                0 
    x_4_0       assign_4                           1 
    x_4_1       capacity_1                        13  Obj                                0 
    x_4_1       assign_4                           1 
    x_4_2       assign_4                           1  Obj                                0 
    x_4_2       capacity_2                        13 
    x_4_3       assign_4                           1  Obj                                0 
    x_4_3       capacity_3                        13 
    x_4_4       assign_4                           1  Obj                                0 
    x_4_4       capacity_4                        13 
    x_4_5       capacity_5                        13  assign_4                           1 
    x_4_5       Obj                                0 
    x_4_6       capacity_6                        13  Obj                                0 
    x_4_6       assign_4                           1 
    x_4_7       assign_4                           1  Obj                                0 
    x_4_7       capacity_7                        13 
    x_4_8       assign_4                           1  capacity_8                        13 
    x_4_8       Obj                                0 
    x_4_9       Obj                                0  assign_4                           1 
    x_4_9       capacity_9                        13 
    x_5_0       capacity_0                        14  assign_5                           1 
    x_5_0       Obj                                0 
    x_5_1       capacity_1                        14  assign_5                           1 
    x_5_1       Obj                                0 
    x_5_2       capacity_2                        14  assign_5                           1 
    x_5_2       Obj                                0 
    x_5_3       capacity_3                        14  assign_5                           1 
    x_5_3       Obj                                0 
    x_5_4       assign_5                           1  capacity_4                        14 
    x_5_4       Obj                                0 
    x_5_5       capacity_5                        14  Obj                                0 
    x_5_5       assign_5                           1 
    x_5_6       Obj                                0  capacity_6                        14 
    x_5_6       assign_5                           1 
    x_5_7       assign_5                           1  capacity_7                        14 
    x_5_7       Obj                                0 
    x_5_8       Obj                                0  assign_5                           1 
    x_5_8       capacity_8                        14 
    x_5_9       Obj                                0  assign_5                           1 
    x_5_9       capacity_9                        14 
    x_6_0       Obj                                0  assign_6                           1 
    x_6_0       capacity_0                        15 
    x_6_1       assign_6                           1  capacity_1                        15 
    x_6_1       Obj                                0 
    x_6_2       capacity_2                        15  Obj                                0 
    x_6_2       assign_6                           1 
    x_6_3       Obj                                0  assign_6                           1 
    x_6_3       capacity_3                        15 
    x_6_4       assign_6                           1  Obj                                0 
    x_6_4       capacity_4                        15 
    x_6_5       assign_6                           1  capacity_5                        15 
    x_6_5       Obj                                0 
    x_6_6       assign_6                           1  capacity_6                        15 
    x_6_6       Obj                                0 
    x_6_7       Obj                                0  capacity_7                        15 
    x_6_7       assign_6                           1 
    x_6_8       Obj                                0  assign_6                           1 
    x_6_8       capacity_8                        15 
    x_6_9       assign_6                           1  capacity_9                        15 
    x_6_9       Obj                                0 
    x_7_0       Obj                                0  assign_7                           1 
    x_7_0       capacity_0                        23 
    x_7_1       capacity_1                        23  Obj                                0 
    x_7_1       assign_7                           1 
    x_7_2       Obj                                0  assign_7                           1 
    x_7_2       capacity_2                        23 
    x_7_3       assign_7                           1  Obj                                0 
    x_7_3       capacity_3                        23 
    x_7_4       assign_7                           1  capacity_4                        23 
    x_7_4       Obj                                0 
    x_7_5       assign_7                           1  Obj                                0 
    x_7_5       capacity_5                        23 
    x_7_6       assign_7                           1  Obj                                0 
    x_7_6       capacity_6                        23 
    x_7_7       assign_7                           1  Obj                                0 
    x_7_7       capacity_7                        23 
    x_7_8       Obj                                0  assign_7                           1 
    x_7_8       capacity_8                        23 
    x_7_9       assign_7                           1  Obj                                0 
    x_7_9       capacity_9                        23 
    x_8_0       assign_8                           1  Obj                                0 
    x_8_0       capacity_0                        16 
    x_8_1       assign_8                           1  Obj                                0 
    x_8_1       capacity_1                        16 
    x_8_2       assign_8                           1  capacity_2                        16 
    x_8_2       Obj                                0 
    x_8_3       capacity_3                        16  assign_8                           1 
    x_8_3       Obj                                0 
    x_8_4       capacity_4                        16  assign_8                           1 
    x_8_4       Obj                                0 
    x_8_5       assign_8                           1  capacity_5                        16 
    x_8_5       Obj                                0 
    x_8_6       capacity_6                        16  Obj                                0 
    x_8_6       assign_8                           1 
    x_8_7       Obj                                0  assign_8                           1 
    x_8_7       capacity_7                        16 
    x_8_8       assign_8                           1  capacity_8                        16 
    x_8_8       Obj                                0 
    x_8_9       capacity_9                        16  assign_8                           1 
    x_8_9       Obj                                0 
    x_9_0       capacity_0                        22  Obj                                0 
    x_9_0       assign_9                           1 
    x_9_1       Obj                                0  assign_9                           1 
    x_9_1       capacity_1                        22 
    x_9_2       Obj                                0  capacity_2                        22 
    x_9_2       assign_9                           1 
    x_9_3       assign_9                           1  capacity_3                        22 
    x_9_3       Obj                                0 
    x_9_4       assign_9                           1  capacity_4                        22 
    x_9_4       Obj                                0 
    x_9_5       assign_9                           1  Obj                                0 
    x_9_5       capacity_5                        22 
    x_9_6       assign_9                           1  capacity_6                        22 
    x_9_6       Obj                                0 
    x_9_7       assign_9                           1  capacity_7                        22 
    x_9_7       Obj                                0 
    x_9_8       Obj                                0  assign_9                           1 
    x_9_8       capacity_8                        22 
    x_9_9       capacity_9                        22  assign_9                           1 
    x_9_9       Obj                                0 
    x_10_0      assign_10                          1  Obj                                0 
    x_10_0      capacity_0                        21 
    x_10_1      Obj                                0  capacity_1                        21 
    x_10_1      assign_10                          1 
    x_10_2      Obj                                0  assign_10                          1 
    x_10_2      capacity_2                        21 
    x_10_3      Obj                                0  assign_10                          1 
    x_10_3      capacity_3                        21 
    x_10_4      assign_10                          1  capacity_4                        21 
    x_10_4      Obj                                0 
    x_10_5      assign_10                          1  capacity_5                        21 
    x_10_5      Obj                                0 
    x_10_6      capacity_6                        21  assign_10                          1 
    x_10_6      Obj                                0 
    x_10_7      Obj                                0  assign_10                          1 
    x_10_7      capacity_7                        21 
    x_10_8      Obj                                0  assign_10                          1 
    x_10_8      capacity_8                        21 
    x_10_9      capacity_9                        21  Obj                                0 
    x_10_9      assign_10                          1 
    x_11_0      assign_11                          1  capacity_0                        30 
    x_11_0      Obj                                0 
    x_11_1      capacity_1                        30  Obj                                0 
    x_11_1      assign_11                          1 
    x_11_2      capacity_2                        30  Obj                                0 
    x_11_2      assign_11                          1 
    x_11_3      Obj                                0  capacity_3                        30 
    x_11_3      assign_11                          1 
    x_11_4      assign_11                          1  Obj                                0 
    x_11_4      capacity_4                        30 
    x_11_5      Obj                                0  assign_11                          1 
    x_11_5      capacity_5                        30 
    x_11_6      capacity_6                        30  assign_11                          1 
    x_11_6      Obj                                0 
    x_11_7      capacity_7                        30  assign_11                          1 
    x_11_7      Obj                                0 
    x_11_8      assign_11                          1  Obj                                0 
    x_11_8      capacity_8                        30 
    x_11_9      capacity_9                        30  assign_11                          1 
    x_11_9      Obj                                0 
    x_12_0      assign_12                          1  Obj                                0 
    x_12_0      capacity_0                        16 
    x_12_1      assign_12                          1  capacity_1                        16 
    x_12_1      Obj                                0 
    x_12_2      Obj                                0  capacity_2                        16 
    x_12_2      assign_12                          1 
    x_12_3      Obj                                0  capacity_3                        16 
    x_12_3      assign_12                          1 
    x_12_4      Obj                                0  assign_12                          1 
    x_12_4      capacity_4                        16 
    x_12_5      capacity_5                        16  Obj                                0 
    x_12_5      assign_12                          1 
    x_12_6      Obj                                0  capacity_6                        16 
    x_12_6      assign_12                          1 
    x_12_7      capacity_7                        16  assign_12                          1 
    x_12_7      Obj                                0 
    x_12_8      Obj                                0  assign_12                          1 
    x_12_8      capacity_8                        16 
    x_12_9      assign_12                          1  capacity_9                        16 
    x_12_9      Obj                                0 
    x_13_0      assign_13                          1  capacity_0                        31 
    x_13_0      Obj                                0 
    x_13_1      Obj                                0  assign_13                          1 
    x_13_1      capacity_1                        31 
    x_13_2      Obj                                0  assign_13                          1 
    x_13_2      capacity_2                        31 
    x_13_3      capacity_3                        31  assign_13                          1 
    x_13_3      Obj                                0 
    x_13_4      capacity_4                        31  Obj                                0 
    x_13_4      assign_13                          1 
    x_13_5      capacity_5                        31  assign_13                          1 
    x_13_5      Obj                                0 
    x_13_6      Obj                                0  assign_13                          1 
    x_13_6      capacity_6                        31 
    x_13_7      assign_13                          1  Obj                                0 
    x_13_7      capacity_7                        31 
    x_13_8      Obj                                0  assign_13                          1 
    x_13_8      capacity_8                        31 
    x_13_9      Obj                                0  assign_13                          1 
    x_13_9      capacity_9                        31 
    x_14_0      Obj                                0  assign_14                          1 
    x_14_0      capacity_0                        24 
    x_14_1      Obj                                0  capacity_1                        24 
    x_14_1      assign_14                          1 
    x_14_2      assign_14                          1  capacity_2                        24 
    x_14_2      Obj                                0 
    x_14_3      capacity_3                        24  Obj                                0 
    x_14_3      assign_14                          1 
    x_14_4      assign_14                          1  Obj                                0 
    x_14_4      capacity_4                        24 
    x_14_5      assign_14                          1  capacity_5                        24 
    x_14_5      Obj                                0 
    x_14_6      capacity_6                        24  Obj                                0 
    x_14_6      assign_14                          1 
    x_14_7      Obj                                0  capacity_7                        24 
    x_14_7      assign_14                          1 
    x_14_8      capacity_8                        24  Obj                                0 
    x_14_8      assign_14                          1 
    x_14_9      assign_14                          1  Obj                                0 
    x_14_9      capacity_9                        24 
    x_15_0      capacity_0                        18  assign_15                          1 
    x_15_0      Obj                                0 
    x_15_1      Obj                                0  assign_15                          1 
    x_15_1      capacity_1                        18 
    x_15_2      Obj                                0  assign_15                          1 
    x_15_2      capacity_2                        18 
    x_15_3      assign_15                          1  Obj                                0 
    x_15_3      capacity_3                        18 
    x_15_4      capacity_4                        18  assign_15                          1 
    x_15_4      Obj                                0 
    x_15_5      Obj                                0  assign_15                          1 
    x_15_5      capacity_5                        18 
    x_15_6      capacity_6                        18  Obj                                0 
    x_15_6      assign_15                          1 
    x_15_7      capacity_7                        18  Obj                                0 
    x_15_7      assign_15                          1 
    x_15_8      Obj                                0  assign_15                          1 
    x_15_8      capacity_8                        18 
    x_15_9      Obj                                0  capacity_9                        18 
    x_15_9      assign_15                          1 
    x_16_0      capacity_0                        18  Obj                                0 
    x_16_0      assign_16                          1 
    x_16_1      Obj                                0  assign_16                          1 
    x_16_1      capacity_1                        18 
    x_16_2      Obj                                0  capacity_2                        18 
    x_16_2      assign_16                          1 
    x_16_3      assign_16                          1  capacity_3                        18 
    x_16_3      Obj                                0 
    x_16_4      Obj                                0  assign_16                          1 
    x_16_4      capacity_4                        18 
    x_16_5      Obj                                0  capacity_5                        18 
    x_16_5      assign_16                          1 
    x_16_6      capacity_6                        18  assign_16                          1 
    x_16_6      Obj                                0 
    x_16_7      capacity_7                        18  Obj                                0 
    x_16_7      assign_16                          1 
    x_16_8      assign_16                          1  capacity_8                        18 
    x_16_8      Obj                                0 
    x_16_9      capacity_9                        18  assign_16                          1 
    x_16_9      Obj                                0 
    x_17_0      assign_17                          1  Obj                                0 
    x_17_0      capacity_0                        23 
    x_17_1      assign_17                          1  capacity_1                        23 
    x_17_1      Obj                                0 
    x_17_2      assign_17                          1  Obj                                0 
    x_17_2      capacity_2                        23 
    x_17_3      assign_17                          1  Obj                                0 
    x_17_3      capacity_3                        23 
    x_17_4      Obj                                0  assign_17                          1 
    x_17_4      capacity_4                        23 
    x_17_5      Obj                                0  assign_17                          1 
    x_17_5      capacity_5                        23 
    x_17_6      capacity_6                        23  Obj                                0 
    x_17_6      assign_17                          1 
    x_17_7      assign_17                          1  capacity_7                        23 
    x_17_7      Obj                                0 
    x_17_8      assign_17                          1  Obj                                0 
    x_17_8      capacity_8                        23 
    x_17_9      capacity_9                        23  Obj                                0 
    x_17_9      assign_17                          1 
    x_18_0      Obj                                0  capacity_0                        23 
    x_18_0      assign_18                          1 
    x_18_1      assign_18                          1  Obj                                0 
    x_18_1      capacity_1                        23 
    x_18_2      assign_18                          1  Obj                                0 
    x_18_2      capacity_2                        23 
    x_18_3      Obj                                0  assign_18                          1 
    x_18_3      capacity_3                        23 
    x_18_4      assign_18                          1  capacity_4                        23 
    x_18_4      Obj                                0 
    x_18_5      assign_18                          1  Obj                                0 
    x_18_5      capacity_5                        23 
    x_18_6      assign_18                          1  Obj                                0 
    x_18_6      capacity_6                        23 
    x_18_7      capacity_7                        23  assign_18                          1 
    x_18_7      Obj                                0 
    x_18_8      capacity_8                        23  Obj                                0 
    x_18_8      assign_18                          1 
    x_18_9      capacity_9                        23  assign_18                          1 
    x_18_9      Obj                                0 
    x_19_0      assign_19                          1  Obj                                0 
    x_19_0      capacity_0                        22 
    x_19_1      assign_19                          1  Obj                                0 
    x_19_1      capacity_1                        22 
    x_19_2      assign_19                          1  Obj                                0 
    x_19_2      capacity_2                        22 
    x_19_3      assign_19                          1  capacity_3                        22 
    x_19_3      Obj                                0 
    x_19_4      assign_19                          1  capacity_4                        22 
    x_19_4      Obj                                0 
    x_19_5      Obj                                0  assign_19                          1 
    x_19_5      capacity_5                        22 
    x_19_6      capacity_6                        22  Obj                                0 
    x_19_6      assign_19                          1 
    x_19_7      Obj                                0  capacity_7                        22 
    x_19_7      assign_19                          1 
    x_19_8      assign_19                          1  capacity_8                        22 
    x_19_8      Obj                                0 
    x_19_9      assign_19                          1  Obj                                0 
    x_19_9      capacity_9                        22 
    x_20_0      assign_20                          1  capacity_0                        26 
    x_20_0      Obj                                0 
    x_20_1      Obj                                0  capacity_1                        26 
    x_20_1      assign_20                          1 
    x_20_2      assign_20                          1  Obj                                0 
    x_20_2      capacity_2                        26 
    x_20_3      assign_20                          1  Obj                                0 
    x_20_3      capacity_3                        26 
    x_20_4      assign_20                          1  Obj                                0 
    x_20_4      capacity_4                        26 
    x_20_5      capacity_5                        26  Obj                                0 
    x_20_5      assign_20                          1 
    x_20_6      Obj                                0  capacity_6                        26 
    x_20_6      assign_20                          1 
    x_20_7      capacity_7                        26  Obj                                0 
    x_20_7      assign_20                          1 
    x_20_8      capacity_8                        26  assign_20                          1 
    x_20_8      Obj                                0 
    x_20_9      capacity_9                        26  Obj                                0 
    x_20_9      assign_20                          1 
    x_21_0      assign_21                          1  capacity_0                        16 
    x_21_0      Obj                                0 
    x_21_1      capacity_1                        16  Obj                                0 
    x_21_1      assign_21                          1 
    x_21_2      capacity_2                        16  assign_21                          1 
    x_21_2      Obj                                0 
    x_21_3      Obj                                0  capacity_3                        16 
    x_21_3      assign_21                          1 
    x_21_4      assign_21                          1  capacity_4                        16 
    x_21_4      Obj                                0 
    x_21_5      assign_21                          1  Obj                                0 
    x_21_5      capacity_5                        16 
    x_21_6      assign_21                          1  capacity_6                        16 
    x_21_6      Obj                                0 
    x_21_7      Obj                                0  assign_21                          1 
    x_21_7      capacity_7                        16 
    x_21_8      Obj                                0  assign_21                          1 
    x_21_8      capacity_8                        16 
    x_21_9      Obj                                0  assign_21                          1 
    x_21_9      capacity_9                        16 
    x_22_0      assign_22                          1  capacity_0                        25 
    x_22_0      Obj                                0 
    x_22_1      Obj                                0  assign_22                          1 
    x_22_1      capacity_1                        25 
    x_22_2      assign_22                          1  Obj                                0 
    x_22_2      capacity_2                        25 
    x_22_3      assign_22                          1  Obj                                0 
    x_22_3      capacity_3                        25 
    x_22_4      assign_22                          1  Obj                                0 
    x_22_4      capacity_4                        25 
    x_22_5      Obj                                0  assign_22                          1 
    x_22_5      capacity_5                        25 
    x_22_6      capacity_6                        25  assign_22                          1 
    x_22_6      Obj                                0 
    x_22_7      capacity_7                        25  assign_22                          1 
    x_22_7      Obj                                0 
    x_22_8      Obj                                0  assign_22                          1 
    x_22_8      capacity_8                        25 
    x_22_9      Obj                                0  capacity_9                        25 
    x_22_9      assign_22                          1 
    x_23_0      Obj                                0  assign_23                          1 
    x_23_0      capacity_0                        17 
    x_23_1      Obj                                0  capacity_1                        17 
    x_23_1      assign_23                          1 
    x_23_2      capacity_2                        17  Obj                                0 
    x_23_2      assign_23                          1 
    x_23_3      Obj                                0  assign_23                          1 
    x_23_3      capacity_3                        17 
    x_23_4      Obj                                0  capacity_4                        17 
    x_23_4      assign_23                          1 
    x_23_5      assign_23                          1  capacity_5                        17 
    x_23_5      Obj                                0 
    x_23_6      assign_23                          1  Obj                                0 
    x_23_6      capacity_6                        17 
    x_23_7      Obj                                0  capacity_7                        17 
    x_23_7      assign_23                          1 
    x_23_8      capacity_8                        17  Obj                                0 
    x_23_8      assign_23                          1 
    x_23_9      capacity_9                        17  assign_23                          1 
    x_23_9      Obj                                0 
    x_24_0      capacity_0                        20  Obj                                0 
    x_24_0      assign_24                          1 
    x_24_1      Obj                                0  capacity_1                        20 
    x_24_1      assign_24                          1 
    x_24_2      Obj                                0  assign_24                          1 
    x_24_2      capacity_2                        20 
    x_24_3      assign_24                          1  capacity_3                        20 
    x_24_3      Obj                                0 
    x_24_4      Obj                                0  capacity_4                        20 
    x_24_4      assign_24                          1 
    x_24_5      Obj                                0  assign_24                          1 
    x_24_5      capacity_5                        20 
    x_24_6      Obj                                0  capacity_6                        20 
    x_24_6      assign_24                          1 
    x_24_7      Obj                                0  assign_24                          1 
    x_24_7      capacity_7                        20 
    x_24_8      assign_24                          1  Obj                                0 
    x_24_8      capacity_8                        20 
    x_24_9      Obj                                0  assign_24                          1 
    x_24_9      capacity_9                        20 
    x_25_0      capacity_0                        17  Obj                                0 
    x_25_0      assign_25                          1 
    x_25_1      assign_25                          1  capacity_1                        17 
    x_25_1      Obj                                0 
    x_25_2      assign_25                          1  Obj                                0 
    x_25_2      capacity_2                        17 
    x_25_3      assign_25                          1  Obj                                0 
    x_25_3      capacity_3                        17 
    x_25_4      Obj                                0  assign_25                          1 
    x_25_4      capacity_4                        17 
    x_25_5      capacity_5                        17  assign_25                          1 
    x_25_5      Obj                                0 
    x_25_6      assign_25                          1  Obj                                0 
    x_25_6      capacity_6                        17 
    x_25_7      Obj                                0  capacity_7                        17 
    x_25_7      assign_25                          1 
    x_25_8      capacity_8                        17  assign_25                          1 
    x_25_8      Obj                                0 
    x_25_9      Obj                                0  assign_25                          1 
    x_25_9      capacity_9                        17 
    x_26_0      capacity_0                        16  Obj                                0 
    x_26_0      assign_26                          1 
    x_26_1      capacity_1                        16  Obj                                0 
    x_26_1      assign_26                          1 
    x_26_2      capacity_2                        16  Obj                                0 
    x_26_2      assign_26                          1 
    x_26_3      capacity_3                        16  Obj                                0 
    x_26_3      assign_26                          1 
    x_26_4      capacity_4                        16  Obj                                0 
    x_26_4      assign_26                          1 
    x_26_5      capacity_5                        16  Obj                                0 
    x_26_5      assign_26                          1 
    x_26_6      assign_26                          1  capacity_6                        16 
    x_26_6      Obj                                0 
    x_26_7      capacity_7                        16  assign_26                          1 
    x_26_7      Obj                                0 
    x_26_8      capacity_8                        16  assign_26                          1 
    x_26_8      Obj                                0 
    x_26_9      Obj                                0  capacity_9                        16 
    x_26_9      assign_26                          1 
    x_27_0      assign_27                          1  Obj                                0 
    x_27_0      capacity_0                        22 
    x_27_1      assign_27                          1  capacity_1                        22 
    x_27_1      Obj                                0 
    x_27_2      assign_27                          1  Obj                                0 
    x_27_2      capacity_2                        22 
    x_27_3      Obj                                0  capacity_3                        22 
    x_27_3      assign_27                          1 
    x_27_4      Obj                                0  assign_27                          1 
    x_27_4      capacity_4                        22 
    x_27_5      capacity_5                        22  Obj                                0 
    x_27_5      assign_27                          1 
    x_27_6      assign_27                          1  Obj                                0 
    x_27_6      capacity_6                        22 
    x_27_7      assign_27                          1  Obj                                0 
    x_27_7      capacity_7                        22 
    x_27_8      capacity_8                        22  assign_27                          1 
    x_27_8      Obj                                0 
    x_27_9      assign_27                          1  capacity_9                        22 
    x_27_9      Obj                                0 
    INTEND      'MARKER'                              'INTEND'                             
RHS
    RHS         assign_0                           1  assign_1                           1 
    RHS         assign_2                           1  assign_3                           1 
    RHS         assign_4                           1  assign_5                           1 
    RHS         assign_6                           1  assign_7                           1 
    RHS         assign_8                           1  assign_9                           1 
    RHS         assign_10                          1  assign_11                          1 
    RHS         assign_12                          1  assign_13                          1 
    RHS         assign_14                          1  assign_15                          1 
    RHS         assign_16                          1  assign_17                          1 
    RHS         assign_18                          1  assign_19                          1 
    RHS         assign_20                          1  assign_21                          1 
    RHS         assign_22                          1  assign_23                          1 
    RHS         assign_24                          1  assign_25                          1 
    RHS         assign_26                          1  assign_27                          1 
    RHS         capacity_0                         0  capacity_1                         0 
    RHS         capacity_2                         0  capacity_3                         0 
    RHS         capacity_4                         0  capacity_5                         0 
    RHS         capacity_6                         0  capacity_7                         0 
    RHS         capacity_8                         0  capacity_9                         0 
    RHS         symmetry_0                         0  symmetry_1                         0 
    RHS         symmetry_2                         0  symmetry_3                         0 
    RHS         symmetry_4                         0  symmetry_5                         0 
    RHS         symmetry_6                         0  symmetry_7                         0 
    RHS         symmetry_8                         0 
BOUNDS
 BV Bound       y_0                                  
 BV Bound       y_1                                  
 BV Bound       y_2                                  
 BV Bound       y_3                                  
 BV Bound       y_4                                  
 BV Bound       y_5                                  
 BV Bound       y_6                                  
 BV Bound       y_7                                  
 BV Bound       y_8                                  
 BV Bound       y_9                                  
 BV Bound       x_0_0                                
 BV Bound       x_0_1                                
 BV Bound       x_0_2                                
 BV Bound       x_0_3                                
 BV Bound       x_0_4                                
 BV Bound       x_0_5                                
 BV Bound       x_0_6                                
 BV Bound       x_0_7                                
 BV Bound       x_0_8                                
 BV Bound       x_0_9                                
 BV Bound       x_1_0                                
 BV Bound       x_1_1                                
 BV Bound       x_1_2                                
 BV Bound       x_1_3                                
 BV Bound       x_1_4                                
 BV Bound       x_1_5                                
 BV Bound       x_1_6                                
 BV Bound       x_1_7                                
 BV Bound       x_1_8                                
 BV Bound       x_1_9                                
 BV Bound       x_2_0                                
 BV Bound       x_2_1                                
 BV Bound       x_2_2                                
 BV Bound       x_2_3                                
 BV Bound       x_2_4                                
 BV Bound       x_2_5                                
 BV Bound       x_2_6                                
 BV Bound       x_2_7                                
 BV Bound       x_2_8                                
 BV Bound       x_2_9                                
 BV Bound       x_3_0                                
 BV Bound       x_3_1                                
 BV Bound       x_3_2                                
 BV Bound       x_3_3                                
 BV Bound       x_3_4                                
 BV Bound       x_3_5                                
 BV Bound       x_3_6                                
 BV Bound       x_3_7                                
 BV Bound       x_3_8                                
 BV Bound       x_3_9                                
 BV Bound       x_4_0                                
 BV Bound       x_4_1                                
 BV Bound       x_4_2                                
 BV Bound       x_4_3                                
 BV Bound       x_4_4                                
 BV Bound       x_4_5                                
 BV Bound       x_4_6                                
 BV Bound       x_4_7                                
 BV Bound       x_4_8                                
 BV Bound       x_4_9                                
 BV Bound       x_5_0                                
 BV Bound       x_5_1                                
 BV Bound       x_5_2                                
 BV Bound       x_5_3                                
 BV Bound       x_5_4                                
 BV Bound       x_5_5                                
 BV Bound       x_5_6                                
 BV Bound       x_5_7                                
 BV Bound       x_5_8                                
 BV Bound       x_5_9                                
 BV Bound       x_6_0                                
 BV Bound       x_6_1                                
 BV Bound       x_6_2                                
 BV Bound       x_6_3                                
 BV Bound       x_6_4                                
 BV Bound       x_6_5                                
 BV Bound       x_6_6                                
 BV Bound       x_6_7                                
 BV Bound       x_6_8                                
 BV Bound       x_6_9                                
 BV Bound       x_7_0                                
 BV Bound       x_7_1                                
 BV Bound       x_7_2                                
 BV Bound       x_7_3                                
 BV Bound       x_7_4                                
 BV Bound       x_7_5                                
 BV Bound       x_7_6                                
 BV Bound       x_7_7                                
 BV Bound       x_7_8                                
 BV Bound       x_7_9                                
 BV Bound       x_8_0                                
 BV Bound       x_8_1                                
 BV Bound       x_8_2                                
 BV Bound       x_8_3                                
 BV Bound       x_8_4                                
 BV Bound       x_8_5                                
 BV Bound       x_8_6                                
 BV Bound       x_8_7                                
 BV Bound       x_8_8                                
 BV Bound       x_8_9                                
 BV Bound       x_9_0                                
 BV Bound       x_9_1                                
 BV Bound       x_9_2                                
 BV Bound       x_9_3                                
 BV Bound       x_9_4                                
 BV Bound       x_9_5                                
 BV Bound       x_9_6                                
 BV Bound       x_9_7                                
 BV Bound       x_9_8                                
 BV Bound       x_9_9                                
 BV Bound       x_10_0                               
 BV Bound       x_10_1                               
 BV Bound       x_10_2                               
 BV Bound       x_10_3                               
 BV Bound       x_10_4                               
 BV Bound       x_10_5                               
 BV Bound       x_10_6                               
 BV Bound       x_10_7                               
 BV Bound       x_10_8                               
 BV Bound       x_10_9                               
 BV Bound       x_11_0                               
 BV Bound       x_11_1                               
 BV Bound       x_11_2                               
 BV Bound       x_11_3                               
 BV Bound       x_11_4                               
 BV Bound       x_11_5                               
 BV Bound       x_11_6                               
 BV Bound       x_11_7                               
 BV Bound       x_11_8                               
 BV Bound       x_11_9                               
 BV Bound       x_12_0                               
 BV Bound       x_12_1                               
 BV Bound       x_12_2                               
 BV Bound       x_12_3                               
 BV Bound       x_12_4                               
 BV Bound       x_12_5                               
 BV Bound       x_12_6                               
 BV Bound       x_12_7                               
 BV Bound       x_12_8                               
 BV Bound       x_12_9                               
 BV Bound       x_13_0                               
 BV Bound       x_13_1                               
 BV Bound       x_13_2                               
 BV Bound       x_13_3                               
 BV Bound       x_13_4                               
 BV Bound       x_13_5                               
 BV Bound       x_13_6                               
 BV Bound       x_13_7                               
 BV Bound       x_13_8                               
 BV Bound       x_13_9                               
 BV Bound       x_14_0                               
 BV Bound       x_14_1                               
 BV Bound       x_14_2                               
 BV Bound       x_14_3                               
 BV Bound       x_14_4                               
 BV Bound       x_14_5                               
 BV Bound       x_14_6                               
 BV Bound       x_14_7                               
 BV Bound       x_14_8                               
 BV Bound       x_14_9                               
 BV Bound       x_15_0                               
 BV Bound       x_15_1                               
 BV Bound       x_15_2                               
 BV Bound       x_15_3                               
 BV Bound       x_15_4                               
 BV Bound       x_15_5                               
 BV Bound       x_15_6                               
 BV Bound       x_15_7                               
 BV Bound       x_15_8                               
 BV Bound       x_15_9                               
 BV Bound       x_16_0                               
 BV Bound       x_16_1                               
 BV Bound       x_16_2                               
 BV Bound       x_16_3                               
 BV Bound       x_16_4                               
 BV Bound       x_16_5                               
 BV Bound       x_16_6                               
 BV Bound       x_16_7                               
 BV Bound       x_16_8                               
 BV Bound       x_16_9                               
 BV Bound       x_17_0                               
 BV Bound       x_17_1                               
 BV Bound       x_17_2                               
 BV Bound       x_17_3                               
 BV Bound       x_17_4                               
 BV Bound       x_17_5                               
 BV Bound       x_17_6                               
 BV Bound       x_17_7                               
 BV Bound       x_17_8                               
 BV Bound       x_17_9                               
 BV Bound       x_18_0                               
 BV Bound       x_18_1                               
 BV Bound       x_18_2                               
 BV Bound       x_18_3                               
 BV Bound       x_18_4                               
 BV Bound       x_18_5                               
 BV Bound       x_18_6                               
 BV Bound       x_18_7                               
 BV Bound       x_18_8                               
 BV Bound       x_18_9                               
 BV Bound       x_19_0                               
 BV Bound       x_19_1                               
 BV Bound       x_19_2                               
 BV Bound       x_19_3                               
 BV Bound       x_19_4                               
 BV Bound       x_19_5                               
 BV Bound       x_19_6                               
 BV Bound       x_19_7                               
 BV Bound       x_19_8                               
 BV Bound       x_19_9                               
 BV Bound       x_20_0                               
 BV Bound       x_20_1                               
 BV Bound       x_20_2                               
 BV Bound       x_20_3                               
 BV Bound       x_20_4                               
 BV Bound       x_20_5                               
 BV Bound       x_20_6                               
 BV Bound       x_20_7                               
 BV Bound       x_20_8                               
 BV Bound       x_20_9                               
 BV Bound       x_21_0                               
 BV Bound       x_21_1                               
 BV Bound       x_21_2                               
 BV Bound       x_21_3                               
 BV Bound       x_21_4                               
 BV Bound       x_21_5                               
 BV Bound       x_21_6                               
 BV Bound       x_21_7                               
 BV Bound       x_21_8                               
 BV Bound       x_21_9                               
 BV Bound       x_22_0                               
 BV Bound       x_22_1                               
 BV Bound       x_22_2                               
 BV Bound       x_22_3                               
 BV Bound       x_22_4                               
 BV Bound       x_22_5                               
 BV Bound       x_22_6                               
 BV Bound       x_22_7                               
 BV Bound       x_22_8                               
 BV Bound       x_22_9                               
 BV Bound       x_23_0                               
 BV Bound       x_23_1                               
 BV Bound       x_23_2                               
 BV Bound       x_23_3                               
 BV Bound       x_23_4                               
 BV Bound       x_23_5                               
 BV Bound       x_23_6                               
 BV Bound       x_23_7                               
 BV Bound       x_23_8                               
 BV Bound       x_23_9                               
 BV Bound       x_24_0                               
 BV Bound       x_24_1                               
 BV Bound       x_24_2                               
 BV Bound       x_24_3                               
 BV Bound       x_24_4                               
 BV Bound       x_24_5                               
 BV Bound       x_24_6                               
 BV Bound       x_24_7                               
 BV Bound       x_24_8                               
 BV Bound       x_24_9                               
 BV Bound       x_25_0                               
 BV Bound       x_25_1                               
 BV Bound       x_25_2                               
 BV Bound       x_25_3                               
 BV Bound       x_25_4                               
 BV Bound       x_25_5                               
 BV Bound       x_25_6                               
 BV Bound       x_25_7                               
 BV Bound       x_25_8                               
 BV Bound       x_25_9                               
 BV Bound       x_26_0                               
 BV Bound       x_26_1                               
 BV Bound       x_26_2                               
 BV Bound       x_26_3                               
 BV Bound       x_26_4                               
 BV Bound       x_26_5                               
 BV Bound       x_26_6                               
 BV Bound       x_26_7                               
 BV Bound       x_26_8                               
 BV Bound       x_26_9                               
 BV Bound       x_27_0                               
 BV Bound       x_27_1                               
 BV Bound       x_27_2                               
 BV Bound       x_27_3                               
 BV Bound       x_27_4                               
 BV Bound       x_27_5                               
 BV Bound       x_27_6                               
 BV Bound       x_27_7                               
 BV Bound       x_27_8                               
 BV Bound       x_27_9                               
ENDATA