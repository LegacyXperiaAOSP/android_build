# Target-specific configuration

# Populate the qcom hardware variants in the project pathmap.
define qcom-set-path-variant
$(call project-set-path-variant,qcom-$(2),TARGET_QCOM_$(1)_VARIANT,hardware/qcom/$(2))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    qcom_flags := -DQCOM_HARDWARE
    qcom_flags += -DQCOM_BSP
    qcom_flags += -DQTI_BSP

    TARGET_USES_QCOM_BSP := true
    TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

    ifeq ($(TARGET_BOARD_PLATFORM),msm7x30)
        # Enable legacy graphics functions
        qcom_flags += -DQCOM_BSP_LEGACY
    endif

    TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)
    CLANG_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    CLANG_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)

$(call project-set-path,qcom-audio,hardware/qcom/audio-caf/$(TARGET_BOARD_PLATFORM))
$(call project-set-path,qcom-display,hardware/qcom/display-caf/$(TARGET_BOARD_PLATFORM))
$(call project-set-path,qcom-media,hardware/qcom/media-caf/$(TARGET_BOARD_PLATFORM))
else
$(call project-set-path,qcom-audio,hardware/qcom/audio/default)
$(call project-set-path,qcom-display,hardware/qcom/display/$(TARGET_BOARD_PLATFORM))
$(call project-set-path,qcom-media,hardware/qcom/media/default)
endif
