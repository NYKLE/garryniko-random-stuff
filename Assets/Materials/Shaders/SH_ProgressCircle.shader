Shader "Shader Graphs/SG_ProgressCircle"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 0)
        _Progress("Progress", Range(0, 1)) = 0.75
        [NoScaleOffset]_MainTex("MainTex", 2D) = "white" {}
        _StartAngle_clockwise("StartAngle(clockwise)", Range(0, 359)) = 0
        [ToggleUI]_Clockwise("Clockwise", Float) = 1
        _OuterDiameter("OuterDiameter", Range(0, 1)) = 1
        _InnerDiameter("InnerDiameter", Range(0, 1)) = 0.75
        [ToggleUI]_Sections("Sections", Float) = 0
        [ToggleUI]_ProgressBySections("ProgressBySections", Float) = 0
        _SectionsAmount("SectionsAmount", Range(1, 360)) = 3
        _SectionsSpacing("SectionsSpacing", Range(0, 1)) = 0.1
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
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_COLOR
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_COLOR
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
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
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
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _OuterDiameter;
        float _InnerDiameter;
        float _Progress;
        float _StartAngle_clockwise;
        float4 _Color;
        float _Clockwise;
        float _SectionsAmount;
        float _SectionsSpacing;
        float _Sections;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
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
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
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
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Ellipse_float(float2 UV, float Width, float Height, out float Out)
        {
        #if defined(SHADER_STAGE_RAY_TRACING)
            Out = saturate((1.0 - length((UV * 2 - 1) / float2(Width, Height))) * 1e7);
        #else
            float d = length((UV * 2 - 1) / float2(Width, Height));
            Out = saturate((1 - d) / fwidth(d));
        #endif
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
            float4 _Property_3135ad32b223401aacf0d3e70b88ea85_Out_0 = _Color;
            UnityTexture2D _Property_c8f1f2a3e264417293a4df714e471a73_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c8f1f2a3e264417293a4df714e471a73_Out_0.tex, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.samplerstate, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            float4 _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2;
            Unity_Multiply_float4_float4(_Property_3135ad32b223401aacf0d3e70b88ea85_Out_0, _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0, _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2);
            float _Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0 = _Sections;
            float _Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0 = _SectionsSpacing;
            float _Property_7ffef707f8f64b49928ed96b41932f92_Out_0 = _SectionsAmount;
            float _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2;
            Unity_Divide_float(180, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2);
            float _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2;
            Unity_Multiply_float_float(_Divide_442c6594cc2d44ca81a43823f3b200af_Out_2, 2, _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2);
            float _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0 = _StartAngle_clockwise;
            float _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2;
            Unity_Subtract_float(360, _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2);
            float _Add_563526be3e69438f804cc1068a459897_Out_2;
            Unity_Add_float(_Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, _Add_563526be3e69438f804cc1068a459897_Out_2);
            float _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2;
            Unity_Divide_float(360, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2);
            float _Multiply_83dc8851a1d243808acac5069abdf755_Out_2;
            Unity_Multiply_float_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2, _Multiply_83dc8851a1d243808acac5069abdf755_Out_2);
            float _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2;
            Unity_Multiply_float_float(_Multiply_83dc8851a1d243808acac5069abdf755_Out_2, 0.5, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2);
            float _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2;
            Unity_Add_float(_Add_563526be3e69438f804cc1068a459897_Out_2, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2, _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2);
            float2 _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2, _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3);
            float2 _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4;
            Unity_PolarCoordinates_float(_Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3, float2 (0.5, 0.5), 1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4);
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_R_1 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[0];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[1];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_B_3 = 0;
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_A_4 = 0;
            float _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1;
            Unity_Fraction_float(_Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1);
            float _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2;
            Unity_Step_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1, _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2);
            float _Property_65097fdd4896422384c87bbd6f742e8b_Out_0 = _Clockwise;
            float _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2;
            Unity_Add_float(_Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, 180, _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2);
            float2 _Rotate_7e6466a4b977463480a95db046409877_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2, _Rotate_7e6466a4b977463480a95db046409877_Out_3);
            float2 _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4;
            Unity_PolarCoordinates_float(_Rotate_7e6466a4b977463480a95db046409877_Out_3, float2 (0.5, 0.5), 1, 1, _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4);
            float _Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0 = _OuterDiameter;
            float _Property_65e0783bc7424a9baf7ff28c1007185e_Out_0 = _ProgressBySections;
            float _Property_93427f94e069431485b77b974035eab9_Out_0 = _Progress;
            float _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2;
            Unity_Divide_float(1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2);
            float _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2;
            Unity_Modulo_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2);
            float _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2;
            Unity_Subtract_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2);
            float _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3;
            Unity_Branch_float(_Property_65e0783bc7424a9baf7ff28c1007185e_Out_0, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2, _Property_93427f94e069431485b77b974035eab9_Out_0, _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3);
            float2 _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0 = float2(-0.0003, 1.0003);
            float _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3;
            Unity_Remap_float(_Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3, float2 (0, 1), _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0, _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3);
            float _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.5, _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2);
            float _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2;
            Unity_Subtract_float(_Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2, 1, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0 = float2(_Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Step_dea8880187f243fabb46b4defce98589_Out_2;
            Unity_Step_float2(_PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4, _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0, _Step_dea8880187f243fabb46b4defce98589_Out_2);
            float _Split_8530eb99f4084c2ca7977a646cb0997c_R_1 = _Step_dea8880187f243fabb46b4defce98589_Out_2[0];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_G_2 = _Step_dea8880187f243fabb46b4defce98589_Out_2[1];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_B_3 = 0;
            float _Split_8530eb99f4084c2ca7977a646cb0997c_A_4 = 0;
            float _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0 = _InnerDiameter;
            float _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4;
            Unity_Ellipse_float(IN.uv0.xy, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4);
            float _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2;
            Unity_Subtract_float(_Split_8530eb99f4084c2ca7977a646cb0997c_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2);
            float _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2;
            Unity_Multiply_float_float(_Split_8530eb99f4084c2ca7977a646cb0997c_G_2, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2);
            float _Split_ce307f626ea547528f1d773d88c15583_R_1 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[0];
            float _Split_ce307f626ea547528f1d773d88c15583_G_2 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[1];
            float _Split_ce307f626ea547528f1d773d88c15583_B_3 = 0;
            float _Split_ce307f626ea547528f1d773d88c15583_A_4 = 0;
            float _Add_349341aeb6714135912fd40f4e7fdf24_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.001, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2);
            float _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2;
            Unity_Subtract_float(1, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2, _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2);
            float _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2;
            Unity_Subtract_float(_Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2, 0.5, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float2 _Vector2_9d6b447876144572a38f0b9d987d4219_Out_0 = float2(_Split_ce307f626ea547528f1d773d88c15583_R_1, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float _Property_4824be76d9a8446c80c2be01e184c116_Out_0 = _OuterDiameter;
            float2 _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0 = float2(_Property_4824be76d9a8446c80c2be01e184c116_Out_0, _Split_ce307f626ea547528f1d773d88c15583_G_2);
            float2 _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2;
            Unity_Step_float2(_Vector2_9d6b447876144572a38f0b9d987d4219_Out_0, _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0, _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2);
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[0];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[1];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_B_3 = 0;
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_A_4 = 0;
            float _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2;
            Unity_Subtract_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2);
            float _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2;
            Unity_Multiply_float_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2);
            float _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3;
            Unity_Branch_float(_Property_65097fdd4896422384c87bbd6f742e8b_Out_0, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3);
            float _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2;
            Unity_Multiply_float_float(_Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2);
            float _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3;
            Unity_Branch_float(_Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3);
            float _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float_float(_SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3, _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            surface.BaseColor = (_Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2.xyz);
            surface.Alpha = _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
        
        
            output.uv0 = input.texCoord0;
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
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
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
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
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
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _OuterDiameter;
        float _InnerDiameter;
        float _Progress;
        float _StartAngle_clockwise;
        float4 _Color;
        float _Clockwise;
        float _SectionsAmount;
        float _SectionsSpacing;
        float _Sections;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
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
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
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
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Ellipse_float(float2 UV, float Width, float Height, out float Out)
        {
        #if defined(SHADER_STAGE_RAY_TRACING)
            Out = saturate((1.0 - length((UV * 2 - 1) / float2(Width, Height))) * 1e7);
        #else
            float d = length((UV * 2 - 1) / float2(Width, Height));
            Out = saturate((1 - d) / fwidth(d));
        #endif
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
            UnityTexture2D _Property_c8f1f2a3e264417293a4df714e471a73_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c8f1f2a3e264417293a4df714e471a73_Out_0.tex, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.samplerstate, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            float _Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0 = _Sections;
            float _Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0 = _SectionsSpacing;
            float _Property_7ffef707f8f64b49928ed96b41932f92_Out_0 = _SectionsAmount;
            float _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2;
            Unity_Divide_float(180, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2);
            float _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2;
            Unity_Multiply_float_float(_Divide_442c6594cc2d44ca81a43823f3b200af_Out_2, 2, _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2);
            float _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0 = _StartAngle_clockwise;
            float _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2;
            Unity_Subtract_float(360, _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2);
            float _Add_563526be3e69438f804cc1068a459897_Out_2;
            Unity_Add_float(_Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, _Add_563526be3e69438f804cc1068a459897_Out_2);
            float _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2;
            Unity_Divide_float(360, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2);
            float _Multiply_83dc8851a1d243808acac5069abdf755_Out_2;
            Unity_Multiply_float_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2, _Multiply_83dc8851a1d243808acac5069abdf755_Out_2);
            float _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2;
            Unity_Multiply_float_float(_Multiply_83dc8851a1d243808acac5069abdf755_Out_2, 0.5, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2);
            float _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2;
            Unity_Add_float(_Add_563526be3e69438f804cc1068a459897_Out_2, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2, _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2);
            float2 _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2, _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3);
            float2 _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4;
            Unity_PolarCoordinates_float(_Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3, float2 (0.5, 0.5), 1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4);
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_R_1 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[0];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[1];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_B_3 = 0;
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_A_4 = 0;
            float _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1;
            Unity_Fraction_float(_Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1);
            float _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2;
            Unity_Step_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1, _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2);
            float _Property_65097fdd4896422384c87bbd6f742e8b_Out_0 = _Clockwise;
            float _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2;
            Unity_Add_float(_Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, 180, _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2);
            float2 _Rotate_7e6466a4b977463480a95db046409877_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2, _Rotate_7e6466a4b977463480a95db046409877_Out_3);
            float2 _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4;
            Unity_PolarCoordinates_float(_Rotate_7e6466a4b977463480a95db046409877_Out_3, float2 (0.5, 0.5), 1, 1, _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4);
            float _Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0 = _OuterDiameter;
            float _Property_65e0783bc7424a9baf7ff28c1007185e_Out_0 = _ProgressBySections;
            float _Property_93427f94e069431485b77b974035eab9_Out_0 = _Progress;
            float _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2;
            Unity_Divide_float(1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2);
            float _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2;
            Unity_Modulo_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2);
            float _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2;
            Unity_Subtract_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2);
            float _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3;
            Unity_Branch_float(_Property_65e0783bc7424a9baf7ff28c1007185e_Out_0, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2, _Property_93427f94e069431485b77b974035eab9_Out_0, _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3);
            float2 _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0 = float2(-0.0003, 1.0003);
            float _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3;
            Unity_Remap_float(_Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3, float2 (0, 1), _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0, _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3);
            float _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.5, _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2);
            float _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2;
            Unity_Subtract_float(_Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2, 1, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0 = float2(_Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Step_dea8880187f243fabb46b4defce98589_Out_2;
            Unity_Step_float2(_PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4, _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0, _Step_dea8880187f243fabb46b4defce98589_Out_2);
            float _Split_8530eb99f4084c2ca7977a646cb0997c_R_1 = _Step_dea8880187f243fabb46b4defce98589_Out_2[0];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_G_2 = _Step_dea8880187f243fabb46b4defce98589_Out_2[1];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_B_3 = 0;
            float _Split_8530eb99f4084c2ca7977a646cb0997c_A_4 = 0;
            float _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0 = _InnerDiameter;
            float _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4;
            Unity_Ellipse_float(IN.uv0.xy, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4);
            float _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2;
            Unity_Subtract_float(_Split_8530eb99f4084c2ca7977a646cb0997c_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2);
            float _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2;
            Unity_Multiply_float_float(_Split_8530eb99f4084c2ca7977a646cb0997c_G_2, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2);
            float _Split_ce307f626ea547528f1d773d88c15583_R_1 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[0];
            float _Split_ce307f626ea547528f1d773d88c15583_G_2 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[1];
            float _Split_ce307f626ea547528f1d773d88c15583_B_3 = 0;
            float _Split_ce307f626ea547528f1d773d88c15583_A_4 = 0;
            float _Add_349341aeb6714135912fd40f4e7fdf24_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.001, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2);
            float _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2;
            Unity_Subtract_float(1, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2, _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2);
            float _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2;
            Unity_Subtract_float(_Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2, 0.5, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float2 _Vector2_9d6b447876144572a38f0b9d987d4219_Out_0 = float2(_Split_ce307f626ea547528f1d773d88c15583_R_1, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float _Property_4824be76d9a8446c80c2be01e184c116_Out_0 = _OuterDiameter;
            float2 _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0 = float2(_Property_4824be76d9a8446c80c2be01e184c116_Out_0, _Split_ce307f626ea547528f1d773d88c15583_G_2);
            float2 _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2;
            Unity_Step_float2(_Vector2_9d6b447876144572a38f0b9d987d4219_Out_0, _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0, _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2);
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[0];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[1];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_B_3 = 0;
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_A_4 = 0;
            float _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2;
            Unity_Subtract_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2);
            float _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2;
            Unity_Multiply_float_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2);
            float _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3;
            Unity_Branch_float(_Property_65097fdd4896422384c87bbd6f742e8b_Out_0, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3);
            float _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2;
            Unity_Multiply_float_float(_Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2);
            float _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3;
            Unity_Branch_float(_Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3);
            float _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float_float(_SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3, _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            surface.Alpha = _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
        
        
            output.uv0 = input.texCoord0;
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
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
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
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 interp0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
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
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _OuterDiameter;
        float _InnerDiameter;
        float _Progress;
        float _StartAngle_clockwise;
        float4 _Color;
        float _Clockwise;
        float _SectionsAmount;
        float _SectionsSpacing;
        float _Sections;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
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
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
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
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Ellipse_float(float2 UV, float Width, float Height, out float Out)
        {
        #if defined(SHADER_STAGE_RAY_TRACING)
            Out = saturate((1.0 - length((UV * 2 - 1) / float2(Width, Height))) * 1e7);
        #else
            float d = length((UV * 2 - 1) / float2(Width, Height));
            Out = saturate((1 - d) / fwidth(d));
        #endif
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
            UnityTexture2D _Property_c8f1f2a3e264417293a4df714e471a73_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c8f1f2a3e264417293a4df714e471a73_Out_0.tex, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.samplerstate, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            float _Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0 = _Sections;
            float _Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0 = _SectionsSpacing;
            float _Property_7ffef707f8f64b49928ed96b41932f92_Out_0 = _SectionsAmount;
            float _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2;
            Unity_Divide_float(180, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2);
            float _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2;
            Unity_Multiply_float_float(_Divide_442c6594cc2d44ca81a43823f3b200af_Out_2, 2, _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2);
            float _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0 = _StartAngle_clockwise;
            float _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2;
            Unity_Subtract_float(360, _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2);
            float _Add_563526be3e69438f804cc1068a459897_Out_2;
            Unity_Add_float(_Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, _Add_563526be3e69438f804cc1068a459897_Out_2);
            float _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2;
            Unity_Divide_float(360, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2);
            float _Multiply_83dc8851a1d243808acac5069abdf755_Out_2;
            Unity_Multiply_float_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2, _Multiply_83dc8851a1d243808acac5069abdf755_Out_2);
            float _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2;
            Unity_Multiply_float_float(_Multiply_83dc8851a1d243808acac5069abdf755_Out_2, 0.5, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2);
            float _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2;
            Unity_Add_float(_Add_563526be3e69438f804cc1068a459897_Out_2, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2, _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2);
            float2 _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2, _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3);
            float2 _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4;
            Unity_PolarCoordinates_float(_Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3, float2 (0.5, 0.5), 1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4);
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_R_1 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[0];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[1];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_B_3 = 0;
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_A_4 = 0;
            float _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1;
            Unity_Fraction_float(_Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1);
            float _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2;
            Unity_Step_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1, _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2);
            float _Property_65097fdd4896422384c87bbd6f742e8b_Out_0 = _Clockwise;
            float _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2;
            Unity_Add_float(_Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, 180, _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2);
            float2 _Rotate_7e6466a4b977463480a95db046409877_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2, _Rotate_7e6466a4b977463480a95db046409877_Out_3);
            float2 _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4;
            Unity_PolarCoordinates_float(_Rotate_7e6466a4b977463480a95db046409877_Out_3, float2 (0.5, 0.5), 1, 1, _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4);
            float _Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0 = _OuterDiameter;
            float _Property_65e0783bc7424a9baf7ff28c1007185e_Out_0 = _ProgressBySections;
            float _Property_93427f94e069431485b77b974035eab9_Out_0 = _Progress;
            float _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2;
            Unity_Divide_float(1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2);
            float _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2;
            Unity_Modulo_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2);
            float _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2;
            Unity_Subtract_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2);
            float _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3;
            Unity_Branch_float(_Property_65e0783bc7424a9baf7ff28c1007185e_Out_0, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2, _Property_93427f94e069431485b77b974035eab9_Out_0, _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3);
            float2 _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0 = float2(-0.0003, 1.0003);
            float _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3;
            Unity_Remap_float(_Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3, float2 (0, 1), _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0, _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3);
            float _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.5, _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2);
            float _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2;
            Unity_Subtract_float(_Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2, 1, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0 = float2(_Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Step_dea8880187f243fabb46b4defce98589_Out_2;
            Unity_Step_float2(_PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4, _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0, _Step_dea8880187f243fabb46b4defce98589_Out_2);
            float _Split_8530eb99f4084c2ca7977a646cb0997c_R_1 = _Step_dea8880187f243fabb46b4defce98589_Out_2[0];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_G_2 = _Step_dea8880187f243fabb46b4defce98589_Out_2[1];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_B_3 = 0;
            float _Split_8530eb99f4084c2ca7977a646cb0997c_A_4 = 0;
            float _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0 = _InnerDiameter;
            float _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4;
            Unity_Ellipse_float(IN.uv0.xy, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4);
            float _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2;
            Unity_Subtract_float(_Split_8530eb99f4084c2ca7977a646cb0997c_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2);
            float _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2;
            Unity_Multiply_float_float(_Split_8530eb99f4084c2ca7977a646cb0997c_G_2, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2);
            float _Split_ce307f626ea547528f1d773d88c15583_R_1 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[0];
            float _Split_ce307f626ea547528f1d773d88c15583_G_2 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[1];
            float _Split_ce307f626ea547528f1d773d88c15583_B_3 = 0;
            float _Split_ce307f626ea547528f1d773d88c15583_A_4 = 0;
            float _Add_349341aeb6714135912fd40f4e7fdf24_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.001, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2);
            float _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2;
            Unity_Subtract_float(1, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2, _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2);
            float _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2;
            Unity_Subtract_float(_Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2, 0.5, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float2 _Vector2_9d6b447876144572a38f0b9d987d4219_Out_0 = float2(_Split_ce307f626ea547528f1d773d88c15583_R_1, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float _Property_4824be76d9a8446c80c2be01e184c116_Out_0 = _OuterDiameter;
            float2 _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0 = float2(_Property_4824be76d9a8446c80c2be01e184c116_Out_0, _Split_ce307f626ea547528f1d773d88c15583_G_2);
            float2 _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2;
            Unity_Step_float2(_Vector2_9d6b447876144572a38f0b9d987d4219_Out_0, _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0, _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2);
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[0];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[1];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_B_3 = 0;
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_A_4 = 0;
            float _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2;
            Unity_Subtract_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2);
            float _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2;
            Unity_Multiply_float_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2);
            float _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3;
            Unity_Branch_float(_Property_65097fdd4896422384c87bbd6f742e8b_Out_0, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3);
            float _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2;
            Unity_Multiply_float_float(_Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2);
            float _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3;
            Unity_Branch_float(_Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3);
            float _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float_float(_SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3, _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            surface.Alpha = _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
        
        
            output.uv0 = input.texCoord0;
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
        // GraphKeywords: <None>
        
        // Defines
        
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_COLOR
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_COLOR
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
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float3 interp0 : INTERP0;
             float4 interp1 : INTERP1;
             float4 interp2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
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
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _OuterDiameter;
        float _InnerDiameter;
        float _Progress;
        float _StartAngle_clockwise;
        float4 _Color;
        float _Clockwise;
        float _SectionsAmount;
        float _SectionsSpacing;
        float _Sections;
        float4 _MainTex_TexelSize;
        float _ProgressBySections;
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
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
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
        
        void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
        {
            float2 delta = UV - Center;
            float radius = length(delta) * 2 * RadialScale;
            float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
            Out = float2(radius, angle);
        }
        
        void Unity_Fraction_float(float In, out float Out)
        {
            Out = frac(In);
        }
        
        void Unity_Step_float(float Edge, float In, out float Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }
        
        void Unity_Ellipse_float(float2 UV, float Width, float Height, out float Out)
        {
        #if defined(SHADER_STAGE_RAY_TRACING)
            Out = saturate((1.0 - length((UV * 2 - 1) / float2(Width, Height))) * 1e7);
        #else
            float d = length((UV * 2 - 1) / float2(Width, Height));
            Out = saturate((1 - d) / fwidth(d));
        #endif
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
            float4 _Property_3135ad32b223401aacf0d3e70b88ea85_Out_0 = _Color;
            UnityTexture2D _Property_c8f1f2a3e264417293a4df714e471a73_Out_0 = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0 = SAMPLE_TEXTURE2D(_Property_c8f1f2a3e264417293a4df714e471a73_Out_0.tex, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.samplerstate, _Property_c8f1f2a3e264417293a4df714e471a73_Out_0.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_R_4 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.r;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_G_5 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.g;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_B_6 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.b;
            float _SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7 = _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0.a;
            float4 _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2;
            Unity_Multiply_float4_float4(_Property_3135ad32b223401aacf0d3e70b88ea85_Out_0, _SampleTexture2D_0868d5318708420cbf1b798336a60390_RGBA_0, _Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2);
            float _Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0 = _Sections;
            float _Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0 = _SectionsSpacing;
            float _Property_7ffef707f8f64b49928ed96b41932f92_Out_0 = _SectionsAmount;
            float _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2;
            Unity_Divide_float(180, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_442c6594cc2d44ca81a43823f3b200af_Out_2);
            float _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2;
            Unity_Multiply_float_float(_Divide_442c6594cc2d44ca81a43823f3b200af_Out_2, 2, _Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2);
            float _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0 = _StartAngle_clockwise;
            float _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2;
            Unity_Subtract_float(360, _Property_3a6e73567c5e413a80bea93e8a9db5dd_Out_0, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2);
            float _Add_563526be3e69438f804cc1068a459897_Out_2;
            Unity_Add_float(_Multiply_ab8e3bd482464aaf87f37b35a2829deb_Out_2, _Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, _Add_563526be3e69438f804cc1068a459897_Out_2);
            float _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2;
            Unity_Divide_float(360, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2);
            float _Multiply_83dc8851a1d243808acac5069abdf755_Out_2;
            Unity_Multiply_float_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Divide_f176ef988d0244f2b584a3bd8d22256f_Out_2, _Multiply_83dc8851a1d243808acac5069abdf755_Out_2);
            float _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2;
            Unity_Multiply_float_float(_Multiply_83dc8851a1d243808acac5069abdf755_Out_2, 0.5, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2);
            float _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2;
            Unity_Add_float(_Add_563526be3e69438f804cc1068a459897_Out_2, _Multiply_c57be20314fe49548e39b500b547dbe3_Out_2, _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2);
            float2 _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_0edfba7ee0d047b69ed5d5ee60b5db0b_Out_2, _Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3);
            float2 _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4;
            Unity_PolarCoordinates_float(_Rotate_40ff0b0752a94dd8a2b2ed39b2ad49d2_Out_3, float2 (0.5, 0.5), 1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4);
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_R_1 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[0];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2 = _PolarCoordinates_1e7653439bde420688395e2c782a4116_Out_4[1];
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_B_3 = 0;
            float _Split_2b4c2796c0164a14963f13f3fe95ffc6_A_4 = 0;
            float _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1;
            Unity_Fraction_float(_Split_2b4c2796c0164a14963f13f3fe95ffc6_G_2, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1);
            float _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2;
            Unity_Step_float(_Property_ec3f2b3ba53a40c7acb3e1100ebc44a1_Out_0, _Fraction_81b3959a9afe404c897fd7bdcc3af111_Out_1, _Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2);
            float _Property_65097fdd4896422384c87bbd6f742e8b_Out_0 = _Clockwise;
            float _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2;
            Unity_Add_float(_Subtract_8feb5fb560f946baac42a289cac6066f_Out_2, 180, _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2);
            float2 _Rotate_7e6466a4b977463480a95db046409877_Out_3;
            Unity_Rotate_Degrees_float(IN.uv0.xy, float2 (0.5, 0.5), _Add_af4e6b26fb914076b415b4c12a665d1a_Out_2, _Rotate_7e6466a4b977463480a95db046409877_Out_3);
            float2 _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4;
            Unity_PolarCoordinates_float(_Rotate_7e6466a4b977463480a95db046409877_Out_3, float2 (0.5, 0.5), 1, 1, _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4);
            float _Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0 = _OuterDiameter;
            float _Property_65e0783bc7424a9baf7ff28c1007185e_Out_0 = _ProgressBySections;
            float _Property_93427f94e069431485b77b974035eab9_Out_0 = _Progress;
            float _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2;
            Unity_Divide_float(1, _Property_7ffef707f8f64b49928ed96b41932f92_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2);
            float _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2;
            Unity_Modulo_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Divide_eed99797d5b741f98a7fcc8afbea3a80_Out_2, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2);
            float _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2;
            Unity_Subtract_float(_Property_93427f94e069431485b77b974035eab9_Out_0, _Modulo_f34d726bfd4c4b9cb96a47251fdcada2_Out_2, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2);
            float _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3;
            Unity_Branch_float(_Property_65e0783bc7424a9baf7ff28c1007185e_Out_0, _Subtract_9b815ff6cc6b46f686ad52a0d572c559_Out_2, _Property_93427f94e069431485b77b974035eab9_Out_0, _Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3);
            float2 _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0 = float2(-0.0003, 1.0003);
            float _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3;
            Unity_Remap_float(_Branch_bbf90c4e0c544fd5a801bce5b99360cf_Out_3, float2 (0, 1), _Vector2_42707e2dfb2a46db853ef5105f5b4e3c_Out_0, _Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3);
            float _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.5, _Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2);
            float _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2;
            Unity_Subtract_float(_Add_8f02c7ce78d1463fa8aeed071e475fde_Out_2, 1, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0 = float2(_Property_00c3bb0e6f22477bac25061aa6c71e18_Out_0, _Subtract_7c80ff93809d4cf1911648b33fa53f5c_Out_2);
            float2 _Step_dea8880187f243fabb46b4defce98589_Out_2;
            Unity_Step_float2(_PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4, _Vector2_c5cf131232e844fd9df2f224090a7e2b_Out_0, _Step_dea8880187f243fabb46b4defce98589_Out_2);
            float _Split_8530eb99f4084c2ca7977a646cb0997c_R_1 = _Step_dea8880187f243fabb46b4defce98589_Out_2[0];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_G_2 = _Step_dea8880187f243fabb46b4defce98589_Out_2[1];
            float _Split_8530eb99f4084c2ca7977a646cb0997c_B_3 = 0;
            float _Split_8530eb99f4084c2ca7977a646cb0997c_A_4 = 0;
            float _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0 = _InnerDiameter;
            float _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4;
            Unity_Ellipse_float(IN.uv0.xy, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Property_5c01601ca26844a6b0c74374d8bc6659_Out_0, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4);
            float _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2;
            Unity_Subtract_float(_Split_8530eb99f4084c2ca7977a646cb0997c_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2);
            float _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2;
            Unity_Multiply_float_float(_Split_8530eb99f4084c2ca7977a646cb0997c_G_2, _Subtract_f83ac5fd27934f549aa90a40114c71b3_Out_2, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2);
            float _Split_ce307f626ea547528f1d773d88c15583_R_1 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[0];
            float _Split_ce307f626ea547528f1d773d88c15583_G_2 = _PolarCoordinates_2a4b58f08d76491abfb50d35d11e9120_Out_4[1];
            float _Split_ce307f626ea547528f1d773d88c15583_B_3 = 0;
            float _Split_ce307f626ea547528f1d773d88c15583_A_4 = 0;
            float _Add_349341aeb6714135912fd40f4e7fdf24_Out_2;
            Unity_Add_float(_Remap_76e1b5e2a2a14d0fbbba608c91106694_Out_3, 0.001, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2);
            float _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2;
            Unity_Subtract_float(1, _Add_349341aeb6714135912fd40f4e7fdf24_Out_2, _Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2);
            float _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2;
            Unity_Subtract_float(_Subtract_f942eb9b9e374b32b60995a6e8254076_Out_2, 0.5, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float2 _Vector2_9d6b447876144572a38f0b9d987d4219_Out_0 = float2(_Split_ce307f626ea547528f1d773d88c15583_R_1, _Subtract_2baac05c436e4890a65379e92eefe5ec_Out_2);
            float _Property_4824be76d9a8446c80c2be01e184c116_Out_0 = _OuterDiameter;
            float2 _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0 = float2(_Property_4824be76d9a8446c80c2be01e184c116_Out_0, _Split_ce307f626ea547528f1d773d88c15583_G_2);
            float2 _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2;
            Unity_Step_float2(_Vector2_9d6b447876144572a38f0b9d987d4219_Out_0, _Vector2_4f6cd1b53c0345c6bf0e07af08433b03_Out_0, _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2);
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[0];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2 = _Step_abdf7e966e3c4889bdd12ff5fff76572_Out_2[1];
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_B_3 = 0;
            float _Split_a2cd7ce71ffb4d7591a24f06c95424b4_A_4 = 0;
            float _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2;
            Unity_Subtract_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_R_1, _Ellipse_d5990ee79a234ebcb6e571f5bc8f0566_Out_4, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2);
            float _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2;
            Unity_Multiply_float_float(_Split_a2cd7ce71ffb4d7591a24f06c95424b4_G_2, _Subtract_d94cf62fa8594adeb80a8e07017b7516_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2);
            float _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3;
            Unity_Branch_float(_Property_65097fdd4896422384c87bbd6f742e8b_Out_0, _Multiply_1edc9d36beff4da3961d2608faa65d51_Out_2, _Multiply_d2840f1af37e4374a5df751b87b75572_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3);
            float _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2;
            Unity_Multiply_float_float(_Step_5bd498a83a4844a69f41b1921c8bda0e_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2);
            float _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3;
            Unity_Branch_float(_Property_0a7600d3b3d4490ba2862a2c25b0954c_Out_0, _Multiply_bc24672b8f164fb5af3de48e439e8825_Out_2, _Branch_5ab56508001f48ad932da34b9fdcda17_Out_3, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3);
            float _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
            Unity_Multiply_float_float(_SampleTexture2D_0868d5318708420cbf1b798336a60390_A_7, _Branch_aff15995a7224e958d43d5335e7ea24b_Out_3, _Multiply_2c481ac1315a46e39dbc044403822117_Out_2);
            surface.BaseColor = (_Multiply_4f4ac34688fc4429b16273d6221e609a_Out_2.xyz);
            surface.Alpha = _Multiply_2c481ac1315a46e39dbc044403822117_Out_2;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
        
        
            output.uv0 = input.texCoord0;
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