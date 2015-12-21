import java.io.*;
import java.util.*;

public class Solution {
    public static void swap(int[] arr, int i, int j) {
        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }

    public static int partition(int[] arr, int first, int last) {
        int p = arr[last];
        int i = first;
        int j = first;

        for (; j <= last; j++) {
            if (arr[j] < p) {
                swap(arr, j, i);
                i++;
            }
        }

        swap(arr, last, i);

        for (int k = 0; k < arr.length; k++) {
            System.out.printf("%d ", arr[k]);
        }
        System.out.println("");

        return i;
    }

    public static void quicksort(int[] arr, int first, int last) {
        int pivot;

        if (first < last) {
            pivot = partition(arr, first, last);

            quicksort(arr, first, pivot - 1);
            quicksort(arr, pivot + 1, last);
        }
    }

    public static void run(int[] arr) {
        quicksort(arr, 0, arr.length - 1);
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int[] ar = new int[n];
        for(int i=0;i<n;i++){
            ar[i]=in.nextInt();
        }
        run(ar);
    }
}

