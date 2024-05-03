import React from 'react'

const FormField = ({ LabelName, placeholder, inputType, isTextArea, value, handleChange }) => {
    return (
        <label className='flex-1 w-full flex flex-col'>
            {LabelName && (
                <span className='font-epilogue font-medium text-[14px] leading-[22px] text-[#808191] mb-[10px]'>{LabelName}</span>
            )}
            {isTextArea ? (
                <textarea/>
            ) : (
                <input
                    required
                    value={value}
                    onChange={handleChange}
                />
            )}
        </label>
    )
}

export default FormField