Shader "Graph/Point Surface"{
    Properties {//allows properties to be changed in the editor
        _Smoothness ("Smoothness", Range(0,1)) = 0.5 //0-1 range with 0.5 as default
    }
    SubShader { //shaders can have sub shaders
        CGPROGRAM //start of the shader code block written in a combination of CG and HLSL
        #pragma surface ConfigureSurface Standard fullforwardshadows //compiler directive that instructs the shader compiler to
        // generate a surface shader with standard lighting and full support for shadows
        #pragma target 3.0 //minimun for shader target level and quality

        struct Input {
            float3 worldPos; //contains world position of what gets rendered
        };

        float _Smoothness;
        void ConfigureSurface (Input input, inout SurfaceOutputStandard surface){//method we referred to in line 7
            surface.Albedo.rg = saturate(input.worldPos.xy * 0.5 + 0.5); //saturate to clamp results from -1 to 1
            surface.Smoothness = _Smoothness;
        }
        ENDCG //end of shader code block
    }

    Fallback "Diffuse" //revert back to the original diffuse shader if anything goes wrong?
}