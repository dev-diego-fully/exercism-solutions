/**
 * @file list_ops.h
 * @brief Vector operations toolkit with functional-style utilities
 */

#pragma once

#include <functional>
#include <numeric>

namespace list_ops
{
    /**
     * @brief Appends elements from right vector to left vector
     * @tparam T Element type
     * @param left Vector to modify
     * @param right Vector to append
     */
    template <typename T>
    void append(std::vector<T> &left, const std::vector<T> &right)
    {
        left.insert(left.end(), right.begin(), right.end());
    }

    /**
     * @brief Concatenates multiple vectors into single vector
     * @tparam T Element type
     * @param collections Vector of vectors to concatenate
     * @return New vector containing all elements in order
     */
    template <typename T>
    std::vector<T> concat(const std::vector<std::vector<T>> &collections)
    {
        std::vector<T> result;

        for (const std::vector<T> &list : collections)
        {
            result.insert(result.end(), list.begin(), list.end());
        }

        return result;
    }

    /**
     * @brief Filters elements using predicate function
     * @tparam T Element type
     * @tparam Callable Predicate type (bool(T))
     * @param vec Input vector
     * @param predicate Filtering condition
     * @return New vector with elements satisfying predicate
     */
    template <typename T, typename Callable>
    std::vector<T> filter(const std::vector<T> &vec, const Callable &predicate)
    {
        std::vector<T> result;

        std::copy_if(vec.begin(), vec.end(),
                     std::back_inserter(result), predicate);

        return result;
    }

    /**
     * @brief Transforms elements using mapper function
     * @tparam T Element type
     * @tparam Callable Mapper type (U(T))
     * @param vec Input vector
     * @param mapper Transformation function
     * @return New vector with transformed elements
     */
    template <typename T, typename Callable>
    std::vector<T> map(const std::vector<T> &vec, const Callable &mapper)
    {
        std::vector<T> result(vec.size());
        std::transform(vec.begin(), vec.end(), result.begin(), mapper);

        return result;
    }

    /**
     * @brief Gets number of elements in vector
     * @tparam T Element type
     * @param vec Input vector
     * @return Element count
     */
    template <typename T>
    size_t length(const std::vector<T> &vec)
    {
        return vec.size();
    }

    /**
     * @brief Left fold (forward iteration) with initial value
     * @tparam T Element type
     * @tparam Acc Accumulator type
     * @tparam Callable Reducer type (Acc(Acc, T))
     * @param vec Input vector
     * @param initial_value Starting accumulator value
     * @param reducer Reduction function
     * @return Final accumulator value
     */
    template <typename T, typename Acc, typename Callable>
    Acc foldl(const std::vector<T> &vec, Acc initial_value,
              const Callable &reducer)
    {
        return std::accumulate(
            vec.begin(), vec.end(),
            initial_value, reducer);
    }

    /**
     * @brief Right fold (reverse iteration) with initial value
     * @tparam T Element type
     * @tparam Acc Accumulator type
     * @tparam Callable Reducer type (Acc(Acc, T))
     * @param vec Input vector
     * @param initial_value Starting accumulator value
     * @param reducer Reduction function
     * @return Final accumulator value
     */
    template <typename T, typename Acc, typename Callable>
    Acc foldr(const std::vector<T> &vec, Acc initial_value,
              const Callable &reducer)
    {
        return std::accumulate(
            vec.rbegin(), vec.rend(),
            initial_value, reducer);
    }

    /**
     * @brief Creates reversed copy of vector
     * @tparam T Element type
     * @param vec Input vector
     * @return New vector with elements in reverse order
     */
    template <typename T>
    std::vector<T> reverse(const std::vector<T> &vec)
    {
        return {vec.rbegin(), vec.rend()};
    }

} // namespace list_ops
