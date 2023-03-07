Shader "Shader Graphs/SH_ProgressCircle-v2"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _Progress("Progress", Range(0, 1)) = 0.75
        [NoScaleOffset]_MainTex("MainTex (Sprite renderer will not be override)", 2D) = "white" {}
        [KeywordEnum(Standard, Rounded, Sections, Rounded Sections Experimental)]_TYPE("Type", Float) = 3
        [KeywordEnum(Clockwise, Anti_Clockwise, Arch)]_FILLDIRECTION("FillDirection", Float) = 2
        _PartialFill("PartialFill", Range(1, 360)) = 220
        _StartAngle("StartAngle (Clockwise)", Range(0, 360)) = 0
        _Diameter("Diameter", Range(0, 1)) = 1
        _Thickness("Thickness", Range(0, 0.5)) = 0.2
        _Sections("Sections", Range(1, 72)) = 3
        [ToggleUI]_ProgressBySections("ProgressBySections", Float) = 1
        _SectionsSpacing("SectionsSpacing", Range(0, 1)) = 0.2
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Unlit"
            "Queue"="Transparent"
            // DisableBatching: <None>
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalSpriteUnlitSubTarget"
        }
        Pass
        {
            Name "Sprite Unlit"
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma exclude_renderers d3d11_9x
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma shader_feature_local _TYPE_STANDARD _TYPE_ROUNDED _TYPE_SECTIONS _TYPE_ROUNDED_SECTIONS_EXPERIMENTAL
        #pragma shader_feature_local _FILLDIRECTION_CLOCKWISE _FILLDIRECTION_ANTI_CLOCKWISE _FILLDIRECTION_ARCH
        
        #if defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_0
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_1
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_2
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_3
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_4
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_5
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_6
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_7
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_8
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_9
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_10
        #else
            #define KEYWORD_PERMUTATION_11
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_COLOR
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SPRITEUNLIT
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 interp0 : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 interp1 : INTERP1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 interp2 : INTERP2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.color = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Progress;
        float _StartAngle;
        float4 _Color;
        float _Sections;
        float _SectionsSpacing;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
        float _Diameter;
        float _Thickness;
        float _PartialFill;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Truncate_float(float In, out float Out)
        {
            Out = trunc(In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Rotate_Degrees_float(float2 UV, float2 Center, float Rotation, out float2 Out)
        {
            //rotation matrix
            Rotation = Rotation * (3.1415926f/180.0f);
            UV -= Center;
            float s = sin(Rotation);
            float c = cos(Rotation);
        
            //center rotation matrix
            float2x2 rMatrix = float2x2(c, -s, s, c);
            rMatrix *= 0.5;
            rMatrix += 0.5;
            rMatrix = rMatrix*2 - 1;
        
            //multiply the UVs by the rotation matrix
            UV.xy = mul(UV.xy, rMatrix);
            UV += Center;
        
            Out = UV;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void ArcCir2_float(float2 Pixel, float Angle, float Radius, float Thick, float Offset, out float Out, out float Clip, out float Clip2, out float2 Vec, out float2 Vec2, out float Rad, out float Rad2){
            Rad = Angle*PI/180;
            
            Rad2 = (Offset+Angle)*PI/180;
            
            Vec.x = sin(Rad);
            
            Vec.y = cos(Rad);
            
            Vec2.x = sin(Rad2);
            
            Vec2.y = cos(Rad2);
            
            Pixel.x = abs(Pixel.x);
            
            Clip=Vec.y*Pixel.x>Vec.x*Pixel.y;
            
            Clip2=Vec2.y*Pixel.x>Vec2.x*Pixel.y;
            
            if(Clip)
            
            {
            
            Out = length(Pixel-Vec*Radius)-Thick;
            
            }
            
            else
            
            {
            
            Out = abs(length(Pixel)-Radius)-Thick;
            
            }
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Property_3135ad32b223401aacf0d3e70b88ea85_Out_0 = _Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            UnityTexture2D _Property_b582ff85d1244643a912f351569130c4_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_b582ff85d1244643a912f351569130c4_Out_0.tex, _Property_b582ff85d1244643a912f351569130c4_Out_0.samplerstate, _Property_b582ff85d1244643a912f351569130c4_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2;
            Unity_Multiply_float4_float4(_Property_3135ad32b223401aacf0d3e70b88ea85_Out_0, _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0, _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_R_1 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[0];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_G_2 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[1];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_B_3 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[2];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2;
            Unity_Multiply_float_float(_Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4, _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _UV_b2f61827e0e647eca2ee938e08515f54_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3;
            Unity_TilingAndOffset_float((_UV_b2f61827e0e647eca2ee938e08515f54_Out_0.xy), float2 (1, 1), float2 (-0.5, -0.5), _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0 = _StartAngle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            Unity_Multiply_float_float(_Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0, -1, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_b254d2269d1843c5b6a293b0493957b6_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_33aade1910354501bbbfc541974b5ac7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2;
            Unity_Comparison_Greater_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, 0.9999, _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_6a511cd80c21475a8177d621e022fdcc_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1;
            Unity_Floor_float(_Property_6a511cd80c21475a8177d621e022fdcc_Out_0, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_d295609adea441dd88c8d00e712a68bb_Out_2;
            Unity_Divide_float(1, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1, _Divide_d295609adea441dd88c8d00e712a68bb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0558166fbbbb4aff839436893357c299_Out_2;
            Unity_Multiply_float_float(_Divide_d295609adea441dd88c8d00e712a68bb_Out_2, 1000, _Multiply_0558166fbbbb4aff839436893357c299_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1;
            Unity_Truncate_float(_Multiply_0558166fbbbb4aff839436893357c299_Out_2, _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2;
            Unity_Divide_float(_Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1, 1000, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_d88d399e96534676b75209c5029d8c97_Out_2;
            Unity_Modulo_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2;
            Unity_Subtract_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3;
            Unity_Branch_float(_Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2, 1, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3;
            Unity_Branch_float(_Property_b254d2269d1843c5b6a293b0493957b6_Out_0, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3, _Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2;
            Unity_Divide_float(_Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0, 2, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_405e691645944409b051d67527028e33_Out_2;
            Unity_Multiply_float_float(_Branch_a1fc8861ca2146ac860bbdec37215233_Out_3, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            Unity_Subtract_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            Unity_Add_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Add_af5ba5eef0fb40229821a16f9e284560_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            #else
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3;
            Unity_Rotate_Degrees_float(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, float2 (0, 0), _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0, _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_46196c88fd8347c2b658109d4adf412f_Out_0 = _Diameter;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0 = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3;
            Unity_Clamp_float(_Property_46196c88fd8347c2b658109d4adf412f_Out_0, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 1, _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2;
            Unity_Subtract_float(_Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2;
            Unity_Multiply_float_float(_Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2, 0.5, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_3299b3666cd84468a58478a53126acd9_Out_2;
            Unity_Multiply_float_float(_Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 0.5, _Multiply_3299b3666cd84468a58478a53126acd9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2;
            Unity_Subtract_float(_Multiply_3299b3666cd84468a58478a53126acd9_Out_2, 0.5, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12;
            ArcCir2_float(_Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3, _Multiply_405e691645944409b051d67527028e33_Out_2, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2, -0.1, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2;
            Unity_Step_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, 0.5, _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1, _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            Unity_Preview_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e360f128f523436ab412aee8343245aa_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1;
            Unity_Floor_float(_Property_e360f128f523436ab412aee8343245aa_Out_0, _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2;
            Unity_Comparison_Greater_float(_Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1, 1, _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_498eb95e111b468e9b442fc4479c21f8_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1;
            Unity_Floor_float(_Property_498eb95e111b468e9b442fc4479c21f8_Out_0, _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2;
            Unity_Divide_float(360, _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            Unity_Multiply_float_float(_Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2, _Multiply_0451b26517d14e88afcbb43143062f62_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0 = _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2;
            Unity_Multiply_float_float(_Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, 0.5, _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = -1;
            #else
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0 = float2(_FillDirection_ca82375ccce141e688957a9ac457e126_Out_0, 1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2;
            Unity_Multiply_float2_float2(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0, _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ce76e76e0d594ac8a4cb1238457de048_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1;
            Unity_Floor_float(_Property_ce76e76e0d594ac8a4cb1238457de048_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2;
            Unity_Modulo_float(_Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, 2, _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_8d2484f2699440e5bc9936319d40f088_Out_2;
            Unity_Divide_float(_Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Divide_8d2484f2699440e5bc9936319d40f088_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, 0.5, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2;
            Unity_Multiply_float_float(_Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2;
            Unity_Subtract_float(0, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2, _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2;
            Unity_Multiply_float_float(_Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_a735e1932173429d9793f551cd26d156_Out_2;
            Unity_Modulo_float(_Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2, 2, _Modulo_a735e1932173429d9793f551cd26d156_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1;
            Unity_Floor_float(_Modulo_a735e1932173429d9793f551cd26d156_Out_2, _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2;
            Unity_Multiply_float_float(_Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2;
            Unity_Add_float(_Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_4fa822679b824e268a5335849539bf9d_Out_3;
            Unity_Branch_float(_Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2, 0, _Branch_4fa822679b824e268a5335849539bf9d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2;
            Unity_Subtract_float(360, _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2;
            Unity_Multiply_float_float(_Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2, 0.5, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            Unity_Subtract_float(_Branch_4fa822679b824e268a5335849539bf9d_Out_3, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2, _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #else
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0, _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2;
            Unity_Multiply_float_float(_Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2, 0.5, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_2a3686cc54cd427a9301f96803a10f57_Out_2;
            Unity_Add_float(_FillDirection_00c85c728eb749289ef1300809395328_Out_0, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2, _Add_2a3686cc54cd427a9301f96803a10f57_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_4bf81e2d48834a8a898dec919dfca641_Out_2;
            Unity_Add_float(_Add_2a3686cc54cd427a9301f96803a10f57_Out_2, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Add_4bf81e2d48834a8a898dec919dfca641_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3;
            Unity_Rotate_Degrees_float(_Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2, float2 (0, 0), _Add_4bf81e2d48834a8a898dec919dfca641_Out_2, _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4;
            Unity_PolarCoordinates_float(_Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3, float2 (0, 0), 1, _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_e631f707985f4e50be9006f45b49a313_R_1 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[0];
            float _Split_e631f707985f4e50be9006f45b49a313_G_2 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[1];
            float _Split_e631f707985f4e50be9006f45b49a313_B_3 = 0;
            float _Split_e631f707985f4e50be9006f45b49a313_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2;
            Unity_Add_float(_Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2, _Split_e631f707985f4e50be9006f45b49a313_G_2, _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2;
            Unity_Modulo_float(_Add_fb774962feaa4cd3a57907dd69e1f233_Out_2, 1, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2;
            Unity_Step_float(_Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2, _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2;
            Unity_Multiply_float_float(_Step_4389c54c344b497ea16e237c53c3c6c7_Out_2, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3;
            Unity_Branch_float(_Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2, 1, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            Unity_Multiply_float_float(_Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3, _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1;
            Unity_Preview_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            Unity_Add_float(_Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2, _Add_65d5e38d90a6414784e256d28c550a9e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_TYPE_STANDARD)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            #elif defined(_TYPE_ROUNDED)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            #elif defined(_TYPE_SECTIONS)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            #else
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float4_float4((_Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2.xxxx), (_Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0.xxxx), _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            #endif
            surface.BaseColor = (_Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2.xyz);
            surface.Alpha = (_Multiply_2c481ac1315a46e39dbc044403822117_Out_2).x;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.uv0 = input.texCoord0;
        #endif
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/2D/ShaderGraph/Includes/SpriteUnlitPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma exclude_renderers d3d11_9x
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature_local _TYPE_STANDARD _TYPE_ROUNDED _TYPE_SECTIONS _TYPE_ROUNDED_SECTIONS_EXPERIMENTAL
        #pragma shader_feature_local _FILLDIRECTION_CLOCKWISE _FILLDIRECTION_ANTI_CLOCKWISE _FILLDIRECTION_ARCH
        
        #if defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_0
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_1
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_2
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_3
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_4
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_5
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_6
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_7
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_8
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_9
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_10
        #else
            #define KEYWORD_PERMUTATION_11
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 interp0 : INTERP0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Progress;
        float _StartAngle;
        float4 _Color;
        float _Sections;
        float _SectionsSpacing;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
        float _Diameter;
        float _Thickness;
        float _PartialFill;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Truncate_float(float In, out float Out)
        {
            Out = trunc(In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Rotate_Degrees_float(float2 UV, float2 Center, float Rotation, out float2 Out)
        {
            //rotation matrix
            Rotation = Rotation * (3.1415926f/180.0f);
            UV -= Center;
            float s = sin(Rotation);
            float c = cos(Rotation);
        
            //center rotation matrix
            float2x2 rMatrix = float2x2(c, -s, s, c);
            rMatrix *= 0.5;
            rMatrix += 0.5;
            rMatrix = rMatrix*2 - 1;
        
            //multiply the UVs by the rotation matrix
            UV.xy = mul(UV.xy, rMatrix);
            UV += Center;
        
            Out = UV;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void ArcCir2_float(float2 Pixel, float Angle, float Radius, float Thick, float Offset, out float Out, out float Clip, out float Clip2, out float2 Vec, out float2 Vec2, out float Rad, out float Rad2){
            Rad = Angle*PI/180;
            
            Rad2 = (Offset+Angle)*PI/180;
            
            Vec.x = sin(Rad);
            
            Vec.y = cos(Rad);
            
            Vec2.x = sin(Rad2);
            
            Vec2.y = cos(Rad2);
            
            Pixel.x = abs(Pixel.x);
            
            Clip=Vec.y*Pixel.x>Vec.x*Pixel.y;
            
            Clip2=Vec2.y*Pixel.x>Vec2.x*Pixel.y;
            
            if(Clip)
            
            {
            
            Out = length(Pixel-Vec*Radius)-Thick;
            
            }
            
            else
            
            {
            
            Out = abs(length(Pixel)-Radius)-Thick;
            
            }
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Property_3135ad32b223401aacf0d3e70b88ea85_Out_0 = _Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            UnityTexture2D _Property_b582ff85d1244643a912f351569130c4_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_b582ff85d1244643a912f351569130c4_Out_0.tex, _Property_b582ff85d1244643a912f351569130c4_Out_0.samplerstate, _Property_b582ff85d1244643a912f351569130c4_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2;
            Unity_Multiply_float4_float4(_Property_3135ad32b223401aacf0d3e70b88ea85_Out_0, _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0, _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_R_1 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[0];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_G_2 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[1];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_B_3 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[2];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2;
            Unity_Multiply_float_float(_Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4, _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _UV_b2f61827e0e647eca2ee938e08515f54_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3;
            Unity_TilingAndOffset_float((_UV_b2f61827e0e647eca2ee938e08515f54_Out_0.xy), float2 (1, 1), float2 (-0.5, -0.5), _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0 = _StartAngle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            Unity_Multiply_float_float(_Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0, -1, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_b254d2269d1843c5b6a293b0493957b6_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_33aade1910354501bbbfc541974b5ac7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2;
            Unity_Comparison_Greater_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, 0.9999, _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_6a511cd80c21475a8177d621e022fdcc_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1;
            Unity_Floor_float(_Property_6a511cd80c21475a8177d621e022fdcc_Out_0, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_d295609adea441dd88c8d00e712a68bb_Out_2;
            Unity_Divide_float(1, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1, _Divide_d295609adea441dd88c8d00e712a68bb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0558166fbbbb4aff839436893357c299_Out_2;
            Unity_Multiply_float_float(_Divide_d295609adea441dd88c8d00e712a68bb_Out_2, 1000, _Multiply_0558166fbbbb4aff839436893357c299_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1;
            Unity_Truncate_float(_Multiply_0558166fbbbb4aff839436893357c299_Out_2, _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2;
            Unity_Divide_float(_Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1, 1000, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_d88d399e96534676b75209c5029d8c97_Out_2;
            Unity_Modulo_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2;
            Unity_Subtract_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3;
            Unity_Branch_float(_Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2, 1, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3;
            Unity_Branch_float(_Property_b254d2269d1843c5b6a293b0493957b6_Out_0, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3, _Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2;
            Unity_Divide_float(_Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0, 2, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_405e691645944409b051d67527028e33_Out_2;
            Unity_Multiply_float_float(_Branch_a1fc8861ca2146ac860bbdec37215233_Out_3, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            Unity_Subtract_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            Unity_Add_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Add_af5ba5eef0fb40229821a16f9e284560_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            #else
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3;
            Unity_Rotate_Degrees_float(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, float2 (0, 0), _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0, _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_46196c88fd8347c2b658109d4adf412f_Out_0 = _Diameter;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0 = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3;
            Unity_Clamp_float(_Property_46196c88fd8347c2b658109d4adf412f_Out_0, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 1, _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2;
            Unity_Subtract_float(_Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2;
            Unity_Multiply_float_float(_Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2, 0.5, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_3299b3666cd84468a58478a53126acd9_Out_2;
            Unity_Multiply_float_float(_Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 0.5, _Multiply_3299b3666cd84468a58478a53126acd9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2;
            Unity_Subtract_float(_Multiply_3299b3666cd84468a58478a53126acd9_Out_2, 0.5, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12;
            ArcCir2_float(_Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3, _Multiply_405e691645944409b051d67527028e33_Out_2, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2, -0.1, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2;
            Unity_Step_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, 0.5, _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1, _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            Unity_Preview_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e360f128f523436ab412aee8343245aa_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1;
            Unity_Floor_float(_Property_e360f128f523436ab412aee8343245aa_Out_0, _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2;
            Unity_Comparison_Greater_float(_Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1, 1, _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_498eb95e111b468e9b442fc4479c21f8_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1;
            Unity_Floor_float(_Property_498eb95e111b468e9b442fc4479c21f8_Out_0, _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2;
            Unity_Divide_float(360, _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            Unity_Multiply_float_float(_Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2, _Multiply_0451b26517d14e88afcbb43143062f62_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0 = _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2;
            Unity_Multiply_float_float(_Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, 0.5, _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = -1;
            #else
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0 = float2(_FillDirection_ca82375ccce141e688957a9ac457e126_Out_0, 1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2;
            Unity_Multiply_float2_float2(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0, _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ce76e76e0d594ac8a4cb1238457de048_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1;
            Unity_Floor_float(_Property_ce76e76e0d594ac8a4cb1238457de048_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2;
            Unity_Modulo_float(_Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, 2, _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_8d2484f2699440e5bc9936319d40f088_Out_2;
            Unity_Divide_float(_Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Divide_8d2484f2699440e5bc9936319d40f088_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, 0.5, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2;
            Unity_Multiply_float_float(_Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2;
            Unity_Subtract_float(0, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2, _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2;
            Unity_Multiply_float_float(_Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_a735e1932173429d9793f551cd26d156_Out_2;
            Unity_Modulo_float(_Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2, 2, _Modulo_a735e1932173429d9793f551cd26d156_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1;
            Unity_Floor_float(_Modulo_a735e1932173429d9793f551cd26d156_Out_2, _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2;
            Unity_Multiply_float_float(_Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2;
            Unity_Add_float(_Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_4fa822679b824e268a5335849539bf9d_Out_3;
            Unity_Branch_float(_Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2, 0, _Branch_4fa822679b824e268a5335849539bf9d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2;
            Unity_Subtract_float(360, _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2;
            Unity_Multiply_float_float(_Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2, 0.5, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            Unity_Subtract_float(_Branch_4fa822679b824e268a5335849539bf9d_Out_3, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2, _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #else
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0, _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2;
            Unity_Multiply_float_float(_Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2, 0.5, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_2a3686cc54cd427a9301f96803a10f57_Out_2;
            Unity_Add_float(_FillDirection_00c85c728eb749289ef1300809395328_Out_0, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2, _Add_2a3686cc54cd427a9301f96803a10f57_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_4bf81e2d48834a8a898dec919dfca641_Out_2;
            Unity_Add_float(_Add_2a3686cc54cd427a9301f96803a10f57_Out_2, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Add_4bf81e2d48834a8a898dec919dfca641_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3;
            Unity_Rotate_Degrees_float(_Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2, float2 (0, 0), _Add_4bf81e2d48834a8a898dec919dfca641_Out_2, _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4;
            Unity_PolarCoordinates_float(_Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3, float2 (0, 0), 1, _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_e631f707985f4e50be9006f45b49a313_R_1 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[0];
            float _Split_e631f707985f4e50be9006f45b49a313_G_2 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[1];
            float _Split_e631f707985f4e50be9006f45b49a313_B_3 = 0;
            float _Split_e631f707985f4e50be9006f45b49a313_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2;
            Unity_Add_float(_Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2, _Split_e631f707985f4e50be9006f45b49a313_G_2, _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2;
            Unity_Modulo_float(_Add_fb774962feaa4cd3a57907dd69e1f233_Out_2, 1, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2;
            Unity_Step_float(_Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2, _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2;
            Unity_Multiply_float_float(_Step_4389c54c344b497ea16e237c53c3c6c7_Out_2, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3;
            Unity_Branch_float(_Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2, 1, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            Unity_Multiply_float_float(_Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3, _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1;
            Unity_Preview_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            Unity_Add_float(_Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2, _Add_65d5e38d90a6414784e256d28c550a9e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_TYPE_STANDARD)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            #elif defined(_TYPE_ROUNDED)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            #elif defined(_TYPE_SECTIONS)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            #else
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float4_float4((_Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2.xxxx), (_Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0.xxxx), _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            #endif
            surface.Alpha = (_Multiply_2c481ac1315a46e39dbc044403822117_Out_2).x;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.uv0 = input.texCoord0;
        #endif
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull Back
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma exclude_renderers d3d11_9x
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        // PassKeywords: <None>
        #pragma shader_feature_local _TYPE_STANDARD _TYPE_ROUNDED _TYPE_SECTIONS _TYPE_ROUNDED_SECTIONS_EXPERIMENTAL
        #pragma shader_feature_local _FILLDIRECTION_CLOCKWISE _FILLDIRECTION_ANTI_CLOCKWISE _FILLDIRECTION_ARCH
        
        #if defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_0
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_1
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_2
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_3
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_4
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_5
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_6
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_7
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_8
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_9
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_10
        #else
            #define KEYWORD_PERMUTATION_11
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 interp0 : INTERP0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Progress;
        float _StartAngle;
        float4 _Color;
        float _Sections;
        float _SectionsSpacing;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
        float _Diameter;
        float _Thickness;
        float _PartialFill;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Truncate_float(float In, out float Out)
        {
            Out = trunc(In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Rotate_Degrees_float(float2 UV, float2 Center, float Rotation, out float2 Out)
        {
            //rotation matrix
            Rotation = Rotation * (3.1415926f/180.0f);
            UV -= Center;
            float s = sin(Rotation);
            float c = cos(Rotation);
        
            //center rotation matrix
            float2x2 rMatrix = float2x2(c, -s, s, c);
            rMatrix *= 0.5;
            rMatrix += 0.5;
            rMatrix = rMatrix*2 - 1;
        
            //multiply the UVs by the rotation matrix
            UV.xy = mul(UV.xy, rMatrix);
            UV += Center;
        
            Out = UV;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void ArcCir2_float(float2 Pixel, float Angle, float Radius, float Thick, float Offset, out float Out, out float Clip, out float Clip2, out float2 Vec, out float2 Vec2, out float Rad, out float Rad2){
            Rad = Angle*PI/180;
            
            Rad2 = (Offset+Angle)*PI/180;
            
            Vec.x = sin(Rad);
            
            Vec.y = cos(Rad);
            
            Vec2.x = sin(Rad2);
            
            Vec2.y = cos(Rad2);
            
            Pixel.x = abs(Pixel.x);
            
            Clip=Vec.y*Pixel.x>Vec.x*Pixel.y;
            
            Clip2=Vec2.y*Pixel.x>Vec2.x*Pixel.y;
            
            if(Clip)
            
            {
            
            Out = length(Pixel-Vec*Radius)-Thick;
            
            }
            
            else
            
            {
            
            Out = abs(length(Pixel)-Radius)-Thick;
            
            }
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Property_3135ad32b223401aacf0d3e70b88ea85_Out_0 = _Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            UnityTexture2D _Property_b582ff85d1244643a912f351569130c4_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_b582ff85d1244643a912f351569130c4_Out_0.tex, _Property_b582ff85d1244643a912f351569130c4_Out_0.samplerstate, _Property_b582ff85d1244643a912f351569130c4_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2;
            Unity_Multiply_float4_float4(_Property_3135ad32b223401aacf0d3e70b88ea85_Out_0, _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0, _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_R_1 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[0];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_G_2 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[1];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_B_3 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[2];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2;
            Unity_Multiply_float_float(_Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4, _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _UV_b2f61827e0e647eca2ee938e08515f54_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3;
            Unity_TilingAndOffset_float((_UV_b2f61827e0e647eca2ee938e08515f54_Out_0.xy), float2 (1, 1), float2 (-0.5, -0.5), _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0 = _StartAngle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            Unity_Multiply_float_float(_Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0, -1, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_b254d2269d1843c5b6a293b0493957b6_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_33aade1910354501bbbfc541974b5ac7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2;
            Unity_Comparison_Greater_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, 0.9999, _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_6a511cd80c21475a8177d621e022fdcc_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1;
            Unity_Floor_float(_Property_6a511cd80c21475a8177d621e022fdcc_Out_0, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_d295609adea441dd88c8d00e712a68bb_Out_2;
            Unity_Divide_float(1, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1, _Divide_d295609adea441dd88c8d00e712a68bb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0558166fbbbb4aff839436893357c299_Out_2;
            Unity_Multiply_float_float(_Divide_d295609adea441dd88c8d00e712a68bb_Out_2, 1000, _Multiply_0558166fbbbb4aff839436893357c299_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1;
            Unity_Truncate_float(_Multiply_0558166fbbbb4aff839436893357c299_Out_2, _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2;
            Unity_Divide_float(_Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1, 1000, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_d88d399e96534676b75209c5029d8c97_Out_2;
            Unity_Modulo_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2;
            Unity_Subtract_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3;
            Unity_Branch_float(_Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2, 1, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3;
            Unity_Branch_float(_Property_b254d2269d1843c5b6a293b0493957b6_Out_0, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3, _Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2;
            Unity_Divide_float(_Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0, 2, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_405e691645944409b051d67527028e33_Out_2;
            Unity_Multiply_float_float(_Branch_a1fc8861ca2146ac860bbdec37215233_Out_3, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            Unity_Subtract_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            Unity_Add_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Add_af5ba5eef0fb40229821a16f9e284560_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            #else
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3;
            Unity_Rotate_Degrees_float(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, float2 (0, 0), _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0, _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_46196c88fd8347c2b658109d4adf412f_Out_0 = _Diameter;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0 = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3;
            Unity_Clamp_float(_Property_46196c88fd8347c2b658109d4adf412f_Out_0, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 1, _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2;
            Unity_Subtract_float(_Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2;
            Unity_Multiply_float_float(_Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2, 0.5, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_3299b3666cd84468a58478a53126acd9_Out_2;
            Unity_Multiply_float_float(_Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 0.5, _Multiply_3299b3666cd84468a58478a53126acd9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2;
            Unity_Subtract_float(_Multiply_3299b3666cd84468a58478a53126acd9_Out_2, 0.5, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12;
            ArcCir2_float(_Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3, _Multiply_405e691645944409b051d67527028e33_Out_2, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2, -0.1, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2;
            Unity_Step_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, 0.5, _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1, _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            Unity_Preview_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e360f128f523436ab412aee8343245aa_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1;
            Unity_Floor_float(_Property_e360f128f523436ab412aee8343245aa_Out_0, _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2;
            Unity_Comparison_Greater_float(_Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1, 1, _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_498eb95e111b468e9b442fc4479c21f8_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1;
            Unity_Floor_float(_Property_498eb95e111b468e9b442fc4479c21f8_Out_0, _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2;
            Unity_Divide_float(360, _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            Unity_Multiply_float_float(_Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2, _Multiply_0451b26517d14e88afcbb43143062f62_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0 = _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2;
            Unity_Multiply_float_float(_Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, 0.5, _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = -1;
            #else
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0 = float2(_FillDirection_ca82375ccce141e688957a9ac457e126_Out_0, 1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2;
            Unity_Multiply_float2_float2(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0, _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ce76e76e0d594ac8a4cb1238457de048_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1;
            Unity_Floor_float(_Property_ce76e76e0d594ac8a4cb1238457de048_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2;
            Unity_Modulo_float(_Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, 2, _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_8d2484f2699440e5bc9936319d40f088_Out_2;
            Unity_Divide_float(_Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Divide_8d2484f2699440e5bc9936319d40f088_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, 0.5, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2;
            Unity_Multiply_float_float(_Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2;
            Unity_Subtract_float(0, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2, _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2;
            Unity_Multiply_float_float(_Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_a735e1932173429d9793f551cd26d156_Out_2;
            Unity_Modulo_float(_Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2, 2, _Modulo_a735e1932173429d9793f551cd26d156_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1;
            Unity_Floor_float(_Modulo_a735e1932173429d9793f551cd26d156_Out_2, _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2;
            Unity_Multiply_float_float(_Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2;
            Unity_Add_float(_Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_4fa822679b824e268a5335849539bf9d_Out_3;
            Unity_Branch_float(_Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2, 0, _Branch_4fa822679b824e268a5335849539bf9d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2;
            Unity_Subtract_float(360, _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2;
            Unity_Multiply_float_float(_Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2, 0.5, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            Unity_Subtract_float(_Branch_4fa822679b824e268a5335849539bf9d_Out_3, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2, _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #else
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0, _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2;
            Unity_Multiply_float_float(_Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2, 0.5, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_2a3686cc54cd427a9301f96803a10f57_Out_2;
            Unity_Add_float(_FillDirection_00c85c728eb749289ef1300809395328_Out_0, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2, _Add_2a3686cc54cd427a9301f96803a10f57_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_4bf81e2d48834a8a898dec919dfca641_Out_2;
            Unity_Add_float(_Add_2a3686cc54cd427a9301f96803a10f57_Out_2, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Add_4bf81e2d48834a8a898dec919dfca641_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3;
            Unity_Rotate_Degrees_float(_Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2, float2 (0, 0), _Add_4bf81e2d48834a8a898dec919dfca641_Out_2, _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4;
            Unity_PolarCoordinates_float(_Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3, float2 (0, 0), 1, _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_e631f707985f4e50be9006f45b49a313_R_1 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[0];
            float _Split_e631f707985f4e50be9006f45b49a313_G_2 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[1];
            float _Split_e631f707985f4e50be9006f45b49a313_B_3 = 0;
            float _Split_e631f707985f4e50be9006f45b49a313_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2;
            Unity_Add_float(_Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2, _Split_e631f707985f4e50be9006f45b49a313_G_2, _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2;
            Unity_Modulo_float(_Add_fb774962feaa4cd3a57907dd69e1f233_Out_2, 1, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2;
            Unity_Step_float(_Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2, _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2;
            Unity_Multiply_float_float(_Step_4389c54c344b497ea16e237c53c3c6c7_Out_2, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3;
            Unity_Branch_float(_Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2, 1, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            Unity_Multiply_float_float(_Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3, _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1;
            Unity_Preview_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            Unity_Add_float(_Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2, _Add_65d5e38d90a6414784e256d28c550a9e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_TYPE_STANDARD)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            #elif defined(_TYPE_ROUNDED)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            #elif defined(_TYPE_SECTIONS)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            #else
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float4_float4((_Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2.xxxx), (_Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0.xxxx), _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            #endif
            surface.Alpha = (_Multiply_2c481ac1315a46e39dbc044403822117_Out_2).x;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.uv0 = input.texCoord0;
        #endif
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Sprite Unlit"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma exclude_renderers d3d11_9x
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma shader_feature_local _TYPE_STANDARD _TYPE_ROUNDED _TYPE_SECTIONS _TYPE_ROUNDED_SECTIONS_EXPERIMENTAL
        #pragma shader_feature_local _FILLDIRECTION_CLOCKWISE _FILLDIRECTION_ANTI_CLOCKWISE _FILLDIRECTION_ARCH
        
        #if defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_0
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_1
        #elif defined(_TYPE_STANDARD) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_2
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_3
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_4
        #elif defined(_TYPE_ROUNDED) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_5
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_6
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_7
        #elif defined(_TYPE_SECTIONS) && defined(_FILLDIRECTION_ARCH)
            #define KEYWORD_PERMUTATION_8
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_CLOCKWISE)
            #define KEYWORD_PERMUTATION_9
        #elif defined(_TYPE_ROUNDED_SECTIONS_EXPERIMENTAL) && defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            #define KEYWORD_PERMUTATION_10
        #else
            #define KEYWORD_PERMUTATION_11
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        #define VARYINGS_NEED_COLOR
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SPRITEFORWARD
        /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 color : COLOR;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 color;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float3 interp0 : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 interp1 : INTERP1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             float4 interp2 : INTERP2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.color;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.color = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Progress;
        float _StartAngle;
        float4 _Color;
        float _Sections;
        float _SectionsSpacing;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
        float _Diameter;
        float _Thickness;
        float _PartialFill;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Truncate_float(float In, out float Out)
        {
            Out = trunc(In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Rotate_Degrees_float(float2 UV, float2 Center, float Rotation, out float2 Out)
        {
            //rotation matrix
            Rotation = Rotation * (3.1415926f/180.0f);
            UV -= Center;
            float s = sin(Rotation);
            float c = cos(Rotation);
        
            //center rotation matrix
            float2x2 rMatrix = float2x2(c, -s, s, c);
            rMatrix *= 0.5;
            rMatrix += 0.5;
            rMatrix = rMatrix*2 - 1;
        
            //multiply the UVs by the rotation matrix
            UV.xy = mul(UV.xy, rMatrix);
            UV += Center;
        
            Out = UV;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void ArcCir2_float(float2 Pixel, float Angle, float Radius, float Thick, float Offset, out float Out, out float Clip, out float Clip2, out float2 Vec, out float2 Vec2, out float Rad, out float Rad2){
            Rad = Angle*PI/180;
            
            Rad2 = (Offset+Angle)*PI/180;
            
            Vec.x = sin(Rad);
            
            Vec.y = cos(Rad);
            
            Vec2.x = sin(Rad2);
            
            Vec2.y = cos(Rad2);
            
            Pixel.x = abs(Pixel.x);
            
            Clip=Vec.y*Pixel.x>Vec.x*Pixel.y;
            
            Clip2=Vec2.y*Pixel.x>Vec2.x*Pixel.y;
            
            if(Clip)
            
            {
            
            Out = length(Pixel-Vec*Radius)-Thick;
            
            }
            
            else
            
            {
            
            Out = abs(length(Pixel)-Radius)-Thick;
            
            }
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Preview_float(float In, out float Out)
        {
            Out = In;
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Property_3135ad32b223401aacf0d3e70b88ea85_Out_0 = _Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            UnityTexture2D _Property_b582ff85d1244643a912f351569130c4_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_b582ff85d1244643a912f351569130c4_Out_0.tex, _Property_b582ff85d1244643a912f351569130c4_Out_0.samplerstate, _Property_b582ff85d1244643a912f351569130c4_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2;
            Unity_Multiply_float4_float4(_Property_3135ad32b223401aacf0d3e70b88ea85_Out_0, _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0, _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_R_1 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[0];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_G_2 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[1];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_B_3 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[2];
            float _Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4 = _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2;
            Unity_Multiply_float_float(_Split_362b5e33f2a84ca2a6a05b4e504094a8_A_4, _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _UV_b2f61827e0e647eca2ee938e08515f54_Out_0 = IN.uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3;
            Unity_TilingAndOffset_float((_UV_b2f61827e0e647eca2ee938e08515f54_Out_0.xy), float2 (1, 1), float2 (-0.5, -0.5), _TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0 = _StartAngle;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            Unity_Multiply_float_float(_Property_dfdb4816af5e420c9cdf12836f0fe55a_Out_0, -1, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_b254d2269d1843c5b6a293b0493957b6_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_33aade1910354501bbbfc541974b5ac7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2;
            Unity_Comparison_Greater_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, 0.9999, _Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_6a511cd80c21475a8177d621e022fdcc_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1;
            Unity_Floor_float(_Property_6a511cd80c21475a8177d621e022fdcc_Out_0, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_d295609adea441dd88c8d00e712a68bb_Out_2;
            Unity_Divide_float(1, _Floor_d5562ab355624d9c86932cc2b130fd5f_Out_1, _Divide_d295609adea441dd88c8d00e712a68bb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0558166fbbbb4aff839436893357c299_Out_2;
            Unity_Multiply_float_float(_Divide_d295609adea441dd88c8d00e712a68bb_Out_2, 1000, _Multiply_0558166fbbbb4aff839436893357c299_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1;
            Unity_Truncate_float(_Multiply_0558166fbbbb4aff839436893357c299_Out_2, _Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2;
            Unity_Divide_float(_Truncate_8660f36182ca40f2b05d17ceabfb009c_Out_1, 1000, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_d88d399e96534676b75209c5029d8c97_Out_2;
            Unity_Modulo_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Divide_6c0108e43c99404695ed53a1f2c8ef0c_Out_2, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2;
            Unity_Subtract_float(_Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Modulo_d88d399e96534676b75209c5029d8c97_Out_2, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3;
            Unity_Branch_float(_Comparison_5816332ad0974fc8ae127422b33bfd6a_Out_2, 1, _Subtract_f0c4edf79d1443d196dc851eb717be42_Out_2, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3;
            Unity_Branch_float(_Property_b254d2269d1843c5b6a293b0493957b6_Out_0, _Branch_9bd0492b7757464298faa8cf27eb42de_Out_3, _Property_33aade1910354501bbbfc541974b5ac7_Out_0, _Branch_a1fc8861ca2146ac860bbdec37215233_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2;
            Unity_Divide_float(_Property_44d1d2fd714b4da2941ca2df79df43ae_Out_0, 2, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_405e691645944409b051d67527028e33_Out_2;
            Unity_Multiply_float_float(_Branch_a1fc8861ca2146ac860bbdec37215233_Out_3, _Divide_154d59d92d4f4632b2f5c6308f6725a7_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            Unity_Subtract_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            Unity_Add_float(_Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Multiply_405e691645944409b051d67527028e33_Out_2, _Add_af5ba5eef0fb40229821a16f9e284560_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Subtract_0026d0e8dcda4e2387a49e25a4033efd_Out_2;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Add_af5ba5eef0fb40229821a16f9e284560_Out_2;
            #else
            float _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0 = _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3;
            Unity_Rotate_Degrees_float(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, float2 (0, 0), _FillDirection_b81c2a8588744d9b99f5e4e01aa34d24_Out_0, _Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_46196c88fd8347c2b658109d4adf412f_Out_0 = _Diameter;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0 = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3;
            Unity_Clamp_float(_Property_46196c88fd8347c2b658109d4adf412f_Out_0, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 1, _Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2;
            Unity_Subtract_float(_Clamp_9d2d5ca7fc944d76844e3b12f42fd297_Out_3, _Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, _Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2;
            Unity_Multiply_float_float(_Subtract_9292220b8d39490a94e00ba54d4ae29f_Out_2, 0.5, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_3299b3666cd84468a58478a53126acd9_Out_2;
            Unity_Multiply_float_float(_Property_e47270ddfe0b4802aad6c4b2e18b71df_Out_0, 0.5, _Multiply_3299b3666cd84468a58478a53126acd9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2;
            Unity_Subtract_float(_Multiply_3299b3666cd84468a58478a53126acd9_Out_2, 0.5, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13;
            float2 _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10;
            float _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12;
            ArcCir2_float(_Rotate_04823d4329b74e6facc2f0c21991eb05_Out_3, _Multiply_405e691645944409b051d67527028e33_Out_2, _Multiply_00ca71ec00654dddb807bd71eac85392_Out_2, _Subtract_8ce44d4ea2884c29af0e166e1acdec7e_Out_2, -0.1, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec_13, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Vec2_9, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad_10, _ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Rad2_12);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2;
            Unity_Step_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Out_4, 0.5, _Step_c9570a544df64eceaf73dae318d7b1e4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip_5, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _OneMinus_eaf234e0d5eb4121844edd68bf50546d_Out_1, _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            Unity_Preview_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_e360f128f523436ab412aee8343245aa_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1;
            Unity_Floor_float(_Property_e360f128f523436ab412aee8343245aa_Out_0, _Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2;
            Unity_Comparison_Greater_float(_Floor_61c58a4548044fb6b5d0dd485b39f1b9_Out_1, 1, _Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_498eb95e111b468e9b442fc4479c21f8_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1;
            Unity_Floor_float(_Property_498eb95e111b468e9b442fc4479c21f8_Out_0, _Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2;
            Unity_Divide_float(360, _Property_61133fa2bee2429e8b4619f8254d87b8_Out_0, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            Unity_Multiply_float_float(_Floor_27f7a5eaaa1f4845904704cd0891c802_Out_1, _Divide_ae46dce4a2a54b018d132b3e40fa85a4_Out_2, _Multiply_0451b26517d14e88afcbb43143062f62_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0 = _Multiply_0451b26517d14e88afcbb43143062f62_Out_2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2;
            Unity_Multiply_float_float(_Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, 0.5, _Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = -1;
            #else
            float _FillDirection_ca82375ccce141e688957a9ac457e126_Out_0 = 1;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0 = float2(_FillDirection_ca82375ccce141e688957a9ac457e126_Out_0, 1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2;
            Unity_Multiply_float2_float2(_TilingAndOffset_f7086ac5d9ef442caa677285c7dd6021_Out_3, _Vector2_4580d880d4a44f75ab762be6e3656f8c_Out_0, _Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0 = _ProgressBySections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_ce76e76e0d594ac8a4cb1238457de048_Out_0 = _Sections;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1;
            Unity_Floor_float(_Property_ce76e76e0d594ac8a4cb1238457de048_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2;
            Unity_Modulo_float(_Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, 2, _Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0 = _PartialFill;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Divide_8d2484f2699440e5bc9936319d40f088_Out_2;
            Unity_Divide_float(_Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Divide_8d2484f2699440e5bc9936319d40f088_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, 0.5, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2;
            Unity_Multiply_float_float(_Modulo_81c9207a57f34a70972ce3e7a35da6f2_Out_2, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2;
            Unity_Subtract_float(0, _Multiply_042285d6ec4943dab0a13ffa06139695_Out_2, _Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0 = _Progress;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2;
            Unity_Multiply_float_float(_Property_664e14a90c4a4a3dbe00e3d5a3dd17c7_Out_0, _Floor_a6ba5f8025db41ee8fdd8133338d646c_Out_1, _Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_a735e1932173429d9793f551cd26d156_Out_2;
            Unity_Modulo_float(_Multiply_790dc9a48c844fbcb75b2cdbb4215268_Out_2, 2, _Modulo_a735e1932173429d9793f551cd26d156_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1;
            Unity_Floor_float(_Modulo_a735e1932173429d9793f551cd26d156_Out_2, _Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2;
            Unity_Multiply_float_float(_Floor_b6c79a76bc5b4c73901253e8242a61fd_Out_1, _Multiply_97fb283f88584bc4a4c83674a644cb69_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2;
            Unity_Add_float(_Subtract_42c84c70bd654fc79440b8ec38ccddbb_Out_2, _Multiply_f4db5ee2e83d4fb0af0df07da55e72af_Out_2, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_4fa822679b824e268a5335849539bf9d_Out_3;
            Unity_Branch_float(_Property_ec21388070dc49d3a378a4cfd8907ffa_Out_0, _Add_59ad64e8614842869d2e68a938dc9ea7_Out_2, 0, _Branch_4fa822679b824e268a5335849539bf9d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2;
            Unity_Subtract_float(360, _Property_2d31d9bbea314048b2f14b34d7c840f6_Out_0, _Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2;
            Unity_Multiply_float_float(_Subtract_291b1bc97e1e40abaa450d5ff843deb6_Out_2, 0.5, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            Unity_Subtract_float(_Branch_4fa822679b824e268a5335849539bf9d_Out_3, _Multiply_ff7bcc520a4942f8b61af9796bb00c52_Out_2, _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_FILLDIRECTION_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #elif defined(_FILLDIRECTION_ANTI_CLOCKWISE)
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = 180;
            #else
            float _FillDirection_00c85c728eb749289ef1300809395328_Out_0 = _Subtract_c849323a86464f668a3677e9b1e2f5e3_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0 = _SectionsSpacing;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2;
            Unity_Multiply_float_float(_Divide_8d2484f2699440e5bc9936319d40f088_Out_2, _Property_7830ae641a624e3fa4a44cf9ba5336a2_Out_0, _Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2;
            Unity_Multiply_float_float(_Multiply_a0db31c43715486eb3b84ce8dc35d970_Out_2, 0.5, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_2a3686cc54cd427a9301f96803a10f57_Out_2;
            Unity_Add_float(_FillDirection_00c85c728eb749289ef1300809395328_Out_0, _Multiply_731c66453a114383a0a29c8d3cf0db14_Out_2, _Add_2a3686cc54cd427a9301f96803a10f57_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_4bf81e2d48834a8a898dec919dfca641_Out_2;
            Unity_Add_float(_Add_2a3686cc54cd427a9301f96803a10f57_Out_2, _Multiply_e0e05c7a23d24f6ab94ba2466412cfbd_Out_2, _Add_4bf81e2d48834a8a898dec919dfca641_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3;
            Unity_Rotate_Degrees_float(_Multiply_42007a2ab0d44c498deac2119e33dac9_Out_2, float2 (0, 0), _Add_4bf81e2d48834a8a898dec919dfca641_Out_2, _Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float2 _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4;
            Unity_PolarCoordinates_float(_Rotate_c0a8acd7e3774b298ceab8188925328d_Out_3, float2 (0, 0), 1, _Float_de790655519d4eb6a4b36ef0fb050cba_Out_0, _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Split_e631f707985f4e50be9006f45b49a313_R_1 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[0];
            float _Split_e631f707985f4e50be9006f45b49a313_G_2 = _PolarCoordinates_7624f556898e4ed285d4f51aef82f8fd_Out_4[1];
            float _Split_e631f707985f4e50be9006f45b49a313_B_3 = 0;
            float _Split_e631f707985f4e50be9006f45b49a313_A_4 = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2;
            Unity_Add_float(_Multiply_d9b60cd3d4854c70b40bc0a642ddf2c6_Out_2, _Split_e631f707985f4e50be9006f45b49a313_G_2, _Add_fb774962feaa4cd3a57907dd69e1f233_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2;
            Unity_Modulo_float(_Add_fb774962feaa4cd3a57907dd69e1f233_Out_2, 1, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2;
            Unity_Step_float(_Property_43f8c1a9e3314895a7ad453f77b7f99f_Out_0, _Modulo_e14d593884874fda91c1eba9362cdfe1_Out_2, _Step_4389c54c344b497ea16e237c53c3c6c7_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1;
            Unity_OneMinus_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2;
            Unity_Multiply_float_float(_Step_4389c54c344b497ea16e237c53c3c6c7_Out_2, _OneMinus_dae4b1bbd8d64e40b73f610276d035ea_Out_1, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3;
            Unity_Branch_float(_Comparison_ac097776b5964d84b10ebc6283c52f4a_Out_2, _Multiply_6b2519a6b0004578a574091cb5f741de_Out_2, 1, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            Unity_Multiply_float_float(_Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2, _Branch_1c3b52cb25934f638e3af43e0d3dc2d6_Out_3, _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1;
            Unity_Preview_float(_ArcCir2CustomFunction_9ca6cf4181bb433da1b450374c3a350a_Clip2_8, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2;
            Unity_Multiply_float_float(_Step_c9570a544df64eceaf73dae318d7b1e4_Out_2, _Preview_6cbc9940362948a0841b00ae6e20aea7_Out_1, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            Unity_Add_float(_Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2, _Multiply_b09d4d4cfc8b4eedb3cc43cafa81c606_Out_2, _Add_65d5e38d90a6414784e256d28c550a9e_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            #if defined(_TYPE_STANDARD)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_0eef9f1c27374b2787a8e6ef2c90245c_Out_2;
            #elif defined(_TYPE_ROUNDED)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Preview_2523900e80384510b5a0d89eaf9d3d57_Out_1;
            #elif defined(_TYPE_SECTIONS)
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Multiply_e3dc253086c74cdda29a3cf311d3e32a_Out_2;
            #else
            float _Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0 = _Add_65d5e38d90a6414784e256d28c550a9e_Out_2;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
            float4 _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float4_float4((_Multiply_dacf1fc553604e0c8e39c412a0198375_Out_2.xxxx), (_Type_0282be0cd04948b3bea33a9a9a60a4f5_Out_0.xxxx), _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            #endif
            surface.BaseColor = (_Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2.xyz);
            surface.Alpha = (_Multiply_2c481ac1315a46e39dbc044403822117_Out_2).x;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1) || defined(KEYWORD_PERMUTATION_2) || defined(KEYWORD_PERMUTATION_3) || defined(KEYWORD_PERMUTATION_4) || defined(KEYWORD_PERMUTATION_5) || defined(KEYWORD_PERMUTATION_6) || defined(KEYWORD_PERMUTATION_7) || defined(KEYWORD_PERMUTATION_8) || defined(KEYWORD_PERMUTATION_9) || defined(KEYWORD_PERMUTATION_10) || defined(KEYWORD_PERMUTATION_11)
        output.uv0 = input.texCoord0;
        #endif
        
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/2D/ShaderGraph/Includes/SpriteUnlitPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}