def maxMatrixSum(matrix):
    rows = len(matrix)
    columns = len(matrix[0])

    def selectandsum(selected_rows, selected_columns):

        if len(selected_rows) == rows and len(selected_columns) == columns:
            return 0
        
        sum_values = []
        
        for r in range(rows):
            if r not in selected_rows:
                for c in range(columns):
                    if c not in selected_columns:

                        new_selected_rows = selected_rows + [r]
                        new_selected_columns = selected_columns + [c]

                        sum_values.append(
                            matrix[r][c] + selectandsum(new_selected_rows, new_selected_columns)
                        )
        
        return max(sum_values) if sum_values else 0

    selected_rows = []
    selected_columns = []

    ans = selectandsum(selected_rows, selected_columns)
    
    return ans



