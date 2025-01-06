def maxMatrixSum(matrix):
    rows = len(matrix)
    columns = len(matrix[0])

    def selectandsum(row, selected_columns):

        if row == rows:
            return 0
        
        sum_values = []
        
        for c in range(columns):
            if c not in selected_columns:

                new_selected_columns = selected_columns + [c]

                sum_values.append(
                    matrix[row][c] + selectandsum(row + 1, new_selected_columns)
                )
        
        return max(sum_values) if sum_values else 0

    selected_columns = []
    ans = selectandsum(0, selected_columns)
    
    return ans
