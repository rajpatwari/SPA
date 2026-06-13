//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package org.spa.helper;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.Map;
import org.spa.entity.NumberMatrix;

public class NumberToMarathiWord {
    public NumberToMarathiWord() {
    }

    static Map load(String[][] data) {
        Map container = new HashMap();

        for(int i = 0; i < data.length; ++i) {
            String key = data[i][1];
            String value = data[i][0];
            container.put(key, value);
        }

        return container;
    }

    public static String convertToWord(double stringNum) {
        Map<String, String> firstTwoLookup = load(NumberMatrix.firstTwo);
        Map<String, String> thirdLookup = load(NumberMatrix.third);
        boolean visited = false;
        String word = "";
        NumberFormat twoDecimalFormatter = new DecimalFormat("#0.00");
        String completeNum = twoDecimalFormatter.format(stringNum);
        String number = completeNum.substring(0, completeNum.indexOf("."));
        String fraction = completeNum.substring(completeNum.indexOf(".") + 1);
        int l = number.length();
        String ft;
        if (l >= 2) {
            ft = number.substring(l - 2, l);
            if (!"00".equals(ft)) {
                word = word + (String)firstTwoLookup.get(ft);
                visited = true;
            }
        }

        if (l >= 3) {
            ft = number.substring(l - 3, l - 2);
            if (!"0".equals(ft)) {
                word = (String)thirdLookup.get(ft) + " " + word;
                visited = true;
            }
        }

        if (l >= 4) {
            if (l == 4) {
                ft = number.substring(l - 4, l - 3);
                if (!"0".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " हजार " + word;
                    visited = true;
                }
            } else if (l >= 5) {
                ft = number.substring(l - 5, l - 3);
                if (!"00".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " हजार " + word;
                    visited = true;
                }
            }
        }

        if (l >= 6) {
            if (l == 6) {
                ft = number.substring(l - 6, l - 5);
                if (!"0".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " लाख " + word;
                    visited = true;
                }
            } else if (l >= 7) {
                ft = number.substring(l - 7, l - 5);
                if (!"00".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " लाख " + word;
                    visited = true;
                }
            }
        }

        if (l >= 8) {
            if (l == 8) {
                ft = number.substring(l - 8, l - 7);
                if (!"0".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " करोड " + word;
                    visited = true;
                }
            } else if (l >= 9) {
                ft = number.substring(l - 9, l - 7);
                if (!"00".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " करोड " + word;
                    visited = true;
                }
            }
        }

        if (l >= 10) {
            if (l == 10) {
                ft = number.substring(l - 10, l - 9);
                if (!"0".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " अरब " + word;
                    visited = true;
                }
            } else if (l >= 11) {
                ft = number.substring(l - 11, l - 9);
                if (!"00".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " अरब " + word;
                    visited = true;
                }
            }
        }

        if (l >= 12) {
            if (l == 12) {
                ft = number.substring(l - 12, l - 11);
                if (!"0".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " खरब " + word;
                    visited = true;
                }
            } else if (l >= 13) {
                ft = number.substring(l - 13, l - 11);
                if (!"00".equals(ft)) {
                    word = (String)firstTwoLookup.get(ft) + " खरब " + word;
                    visited = true;
                }
            }
        }

        ft = "";
        if (l >= 2 && !"00".equals(fraction)) {
            ft = (String)firstTwoLookup.get(fraction);
            ft = " आणि " + ft + " पैसे";
            visited = true;
        }

        if (visited) {
            word = word + ft + " मात्र";
        }

        return word;
    }

    public static void main(String[] args) {
        double number = 1.0D;
        System.out.println(convertToWord(number));
    }
}
